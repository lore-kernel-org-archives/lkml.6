Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3E1C282D7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4775218A1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FmCO67VL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbfBLBsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 20:48:43 -0500
Received: from mail-eopbgr680100.outbound.protection.outlook.com ([40.107.68.100]:43648
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726079AbfBLBsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 20:48:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogkp6pOfNCesQuySg/44pmy14D0T+5w9WoBzYJaHK0Y=;
 b=FmCO67VLodBkjEYcegFzv8w5MmxO3gXfIcvsegakyQ5FiYqwXlYU0D7ymYfsKZzIN1xMkD2OW3U+PWac/AbsGaxdEI93Jx0zfpBYZqILEP+pmdIcVvYYPhGDGFUJu27Wne84aCsa/VeF3KF7RzDvcd5H+6Ohewh4sipZna79uFA=
Received: from DM5PR21MB0140.namprd21.prod.outlook.com (10.173.173.15) by
 DM5PR21MB0763.namprd21.prod.outlook.com (10.173.172.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1643.0; Tue, 12 Feb 2019 01:48:36 +0000
Received: from DM5PR21MB0140.namprd21.prod.outlook.com
 ([fe80::14fc:ecd:4819:e723]) by DM5PR21MB0140.namprd21.prod.outlook.com
 ([fe80::14fc:ecd:4819:e723%13]) with mapi id 15.20.1643.004; Tue, 12 Feb 2019
 01:48:36 +0000
From:   Pavel Shilovskiy <pshilov@microsoft.com>
To:     Sasha Levin <sashal@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     Steven French <Steven.French@microsoft.com>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>
Subject: RE: [PATCH AUTOSEL 4.20 40/42] CIFS: Move credit processing to mid
 callbacks for SMB3
Thread-Topic: [PATCH AUTOSEL 4.20 40/42] CIFS: Move credit processing to mid
 callbacks for SMB3
Thread-Index: AQHUwKgRxb6nGrt8ykKkmMfryN1KoaXbZtXw
Date:   Tue, 12 Feb 2019 01:48:36 +0000
Message-ID: <DM5PR21MB0140FF0B60DBF17DF7C676BEB6650@DM5PR21MB0140.namprd21.prod.outlook.com>
References: <20190209184734.125935-1-sashal@kernel.org>
 <20190209184734.125935-40-sashal@kernel.org>
In-Reply-To: <20190209184734.125935-40-sashal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=pshilov@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-02-12T01:48:34.3162771Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d548e795-b34d-4c98-bbda-376cf67d338a;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [2601:600:8080:117f:d0a:2088:54:bcdd]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d0c0f4e-bd52-4588-590f-08d6908c341d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0763;
x-ms-traffictypediagnostic: DM5PR21MB0763:
x-ms-exchange-purlcount: 2
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;DM5PR21MB0763;23:/BGNwikXV1WVk28wOitmK4sN0MiRQwvQ6YPSGA31u?=
 =?us-ascii?Q?hi0J6DDj6xEjKA1IDuQhXDjvjEk8KSu4u5/kpdSNvnXQVSWBh11bJDhAPaC0?=
 =?us-ascii?Q?Xy4GfojssvXYJHwFRmCcEu622wXqq3y3LY8o5SjodE0rairBu2CA8SFJ+nOa?=
 =?us-ascii?Q?CzxgipV860w/FLOnijqIcIXJa2lClmQonsfXTKgCvrU7Eq5H495TpUn+2yS1?=
 =?us-ascii?Q?O3pXoSg5p014KEbCO7cYqXksXUaTDtjtyMe27ijzBj0dDsL4yhAYsO6Bk7od?=
 =?us-ascii?Q?pXXA4c9pJihC39Ksct6qTNiBFyRiL5Vn0N1OrT4AriKzBXhTA9c5cH1EMPCp?=
 =?us-ascii?Q?2D0UQL8CJWNcjQKyx6nTdBOedpDjyFZA2e0SIvqk33ReCKcokSEXNKgwocsR?=
 =?us-ascii?Q?VxLLMhRD0yb8s0Q+gD0f0kWFGIM1DxUc5aNmhMvyedf8XsXZbfi1JQ1BAkrV?=
 =?us-ascii?Q?TC2ZifnrlTV2drQ10EeMMeEFAsWRIUdKUSZVdEdzNaFjeF1/te7w3Lmy9+lb?=
 =?us-ascii?Q?H6957qmdXxjia/iDs35t6MAJwd+zVPE8FXgZ+KUnJ38QE2yfXs9fdt4iYxat?=
 =?us-ascii?Q?CXkNrFPN5VF3IEMK2If0Cskh8UD0BDx5QSqLop/+4ERSXnE0r5uPmmUhOlVG?=
 =?us-ascii?Q?i5zvMeQPkOXskInZhb3LplGU1DV3jbOiqWwhu+NSKlOyE8e3p03yMK3BwsrV?=
 =?us-ascii?Q?dOX4MT1C96iozdvgi/BCKTXdC8FXemso7/CbbIBhqPgyQmtKeA0CXZrKMA75?=
 =?us-ascii?Q?2qaQgOCTBSa8O/rT51ZvLcAF84wtnGAqn3rVeiUVT76PWlrD6ySaP66QCPxk?=
 =?us-ascii?Q?7mmjAktlCKtOAqlgj2lIaDw7XMTcmZEHMnkOJU24+nTSRo/BQIkLg8Ds/cYz?=
 =?us-ascii?Q?sfcA7Yu2Eyip6Vgx9q8jrhnwxAnxfMHTur/EjdewEMWwn6SQmCIWE7E5tU1d?=
 =?us-ascii?Q?/TKmpvWkM2d3f7uHeAGoU/8QGRfjU+DQNWpNWAViMlGEtzrT0lXrkfTBLiTp?=
 =?us-ascii?Q?NaFxF8/zOio34g38HaDHU7B885NQaeFjX45OyVwpsC5LeDhgmrZrv53LSBMU?=
 =?us-ascii?Q?9duqOCJHAea1vaRLBn+XLlXk9XfSTO89MqxZSoq7p2j9SPliVZQm/HDAEJqH?=
 =?us-ascii?Q?G5sScQVwbyeNWDGQpIavkre3os5zu9lqwj+UUw7rcUd2nFINnk89gaeSdgTU?=
 =?us-ascii?Q?m2Jve4fmkwrKRKq4uv73Gp+NMvdzv9RBCkX/rzp/gSci8K0Ba4edZacve9I6?=
 =?us-ascii?Q?hzJDkPLDn2xazRzpU88yCi8LTCSGVD1K1k3qO+WH9a0W/ue3rqRpl9F8bVCF?=
 =?us-ascii?Q?MtV08NCVu7ZU2BD1CrWDFmWtZXf0xAMJhO9gshRUczn15jZQ3xyDhTMIb7Q9?=
 =?us-ascii?Q?5hdT6V1cJhbdqoPikI+TBunWmSYg9fgO8mpXRVICsliu6Qs?=
x-microsoft-antispam-prvs: <DM5PR21MB07636DD72D959E26CB7D2688B6650@DM5PR21MB0763.namprd21.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(396003)(366004)(39860400002)(199004)(189003)(69234005)(476003)(86362001)(81166006)(81156014)(8676002)(486006)(8936002)(446003)(2201001)(46003)(11346002)(76176011)(6506007)(97736004)(102836004)(106356001)(105586002)(6346003)(99286004)(10090500001)(7696005)(71200400001)(186003)(71190400001)(86612001)(6116002)(4326008)(25786009)(14454004)(478600001)(55016002)(10290500003)(6306002)(9686003)(229853002)(966005)(6436002)(7736002)(33656002)(256004)(14444005)(8990500004)(2501003)(110136005)(54906003)(53936002)(74316002)(305945005)(22452003)(316002)(217873002)(2906002)(6246003)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0763;H:DM5PR21MB0140.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pshilov@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /Tu29qSPpLZrpqOSbTI4nxirgUUJ2H2z0cvWi8S7bVmLIEzEM6NqK5QjOkPkiXcyYE3kgdL0Ba+4aOS8QlKWQSatWHAf7zlVWfmsSOmnyclxlSFbWgwR4aPo873X5oCHj9+F/oySPetwbhUss3oeknh9/s1fgmGrf1lOd/w+eh66/QeE2//pKQIn8vvv9jX6PqHI7UB9yWaVwRFcjdiLbmpB6zSNaavtRwJ5vPvGpO8/aQHi5yBIuPsJZe700DSWAdDlH9BKNVEx/It5pGh6fuMW6Dgh9Da2MkuOAil3ZB2r9MTQhFgXCusNUDQu1Pk+xvuWOJB+SkcqJ8QYmQhgHahbbZZCmkwQ3nibYTGVtLByWn3nhn05IS9B2zC+IfkFeFiDSHyNl4/JhPY2URT4NJ3kmgOTp5buPXOs1Bb82Ts=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0c0f4e-bd52-4588-590f-08d6908c341d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 01:48:36.3013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0763
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sat, Feb 9 2019, 10:56AM, Sasha Levin <sashal@kernel.org> wrote:
>
> From: Pavel Shilovsky <pshilov@microsoft.com>
>
> [ Upstream commit ee258d79159afed52ca9372aeb9c1a51e89b32ee ]
>
> Currently we account for credits in the thread initiating a request
> and waiting for a response. The demultiplex thread receives the response,
> wakes up the thread and the latter collects credits from the response
> buffer and add them to the server structure on the client. This approach
> is not accurate, because it may race with reconnect events in the
> demultiplex thread which resets the number of credits.
>
> Fix this by moving credit processing to new mid callbacks that collect
> credits granted by the server from the response in the demultiplex thread=
.
>
> Signed-off-by: Pavel Shilovsky <pshilov@microsoft.com>
> Signed-off-by: Steve French <stfrench@microsoft.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/cifs/transport.c | 51 ++++++++++++++++++++++++++++++---------------
>  1 file changed, 34 insertions(+), 17 deletions(-)
>
> diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
> index 4dbf62bb51b2..0dab276eced8 100644
> --- a/fs/cifs/transport.c
> +++ b/fs/cifs/transport.c
> @@ -781,12 +781,7 @@ cifs_setup_request(struct cifs_ses *ses, struct smb_=
rqst *rqst)
>  }
>
>  static void
> -cifs_noop_callback(struct mid_q_entry *mid)
> -{
> -}
> -
> -static void
> -cifs_cancelled_callback(struct mid_q_entry *mid)
> +cifs_compound_callback(struct mid_q_entry *mid)
>  {
>         struct TCP_Server_Info *server =3D mid->server;
>         unsigned int optype =3D mid->optype;
> @@ -799,10 +794,23 @@ cifs_cancelled_callback(struct mid_q_entry *mid)
>                         cifs_dbg(FYI, "Bad state for cancelled MID\n");
>         }
>
> -       DeleteMidQEntry(mid);
>         add_credits(server, credits_received, optype);
>  }
>
> +static void
> +cifs_compound_last_callback(struct mid_q_entry *mid)
> +{
> +       cifs_compound_callback(mid);
> +       cifs_wake_up_task(mid);
> +}
> +
> +static void
> +cifs_cancelled_callback(struct mid_q_entry *mid)
> +{
> +       cifs_compound_callback(mid);
> +       DeleteMidQEntry(mid);
> +}
> +
>  int
>  compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
>                    const int flags, const int num_rqst, struct smb_rqst *=
rqst,
> @@ -880,11 +888,14 @@ compound_send_recv(const unsigned int xid, struct c=
ifs_ses *ses,
>                 midQ[i]->mid_state =3D MID_REQUEST_SUBMITTED;
>                 midQ[i]->optype =3D optype;
>                 /*
> -                * We don't invoke the callback compounds unless it is th=
e last
> -                * request.
> +                * Invoke callback for every part of the compound chain
> +                * to calculate credits properly. Wake up this thread onl=
y when
> +                * the last element is received.
>                  */
>                 if (i < num_rqst - 1)
> -                       midQ[i]->callback =3D cifs_noop_callback;
> +                       midQ[i]->callback =3D cifs_compound_callback;
> +               else
> +                       midQ[i]->callback =3D cifs_compound_last_callback=
;
>         }
>         cifs_in_send_inc(ses->server);
>         rc =3D smb_send_rqst(ses->server, num_rqst, rqst, flags);
> @@ -898,8 +909,20 @@ compound_send_recv(const unsigned int xid, struct ci=
fs_ses *ses,
>
>         mutex_unlock(&ses->server->srv_mutex);
>
> -       if (rc < 0)
> +       if (rc < 0) {
> +               /* Sending failed for some reason - return credits back *=
/
> +               for (i =3D 0; i < num_rqst; i++)
> +                       add_credits(ses->server, credits[i], optype);
>                 goto out;
> +       }
> +
> +       /*
> +        * At this point the request is passed to the network stack - we =
assume
> +        * that any credits taken from the server structure on the client=
 have
> +        * been spent and we can't return them back. Once we receive resp=
onses
> +        * we will collect credits granted by the server in the mid callb=
acks
> +        * and add those credits to the server structure.
> +        */
>
>         /*
>          * Compounding is never used during session establish.
> @@ -932,11 +955,6 @@ compound_send_recv(const unsigned int xid, struct ci=
fs_ses *ses,
>                 }
>         }
>
> -       for (i =3D 0; i < num_rqst; i++)
> -               if (!cancelled_mid[i] && midQ[i]->resp_buf
> -                   && (midQ[i]->mid_state =3D=3D MID_RESPONSE_RECEIVED))
> -                       credits[i] =3D ses->server->ops->get_credits(midQ=
[i]);
> -
>         for (i =3D 0; i < num_rqst; i++) {
>                 if (rc < 0)
>                         goto out;
> @@ -995,7 +1013,6 @@ out:
>         for (i =3D 0; i < num_rqst; i++) {
>                 if (!cancelled_mid[i])
>                         cifs_delete_mid(midQ[i]);
> -               add_credits(ses->server, credits[i], optype);
>         }
>
>         return rc;
> --
> 2.19.1
>

Please apply the following two patches too:

https://patchwork.ozlabs.org/patch/1030180/
https://patchwork.ozlabs.org/patch/1030181/

The 1st fixes some minor regressions introduces by the proposing patch and =
the 2nd adds the same logic to processing of async responses as the proposi=
ng patch is doing for sync ones.

--
Best regards,
Pavel Shilovsky
