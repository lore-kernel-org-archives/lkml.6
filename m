Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137AEECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94EC52075E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="M0gWREde";
	dkim=pass (1024-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="ViH4Z1/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94EC52075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ericsson.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730502AbeGQUiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:38:51 -0400
Received: from sesbmg22.ericsson.net ([193.180.251.48]:64970 "EHLO
        sesbmg22.ericsson.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730238AbeGQUiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:38:51 -0400
X-Greylist: delayed 905 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Jul 2018 16:38:49 EDT
DKIM-Signature: v=1; a=rsa-sha256; d=ericsson.com; s=mailgw201801; c=relaxed/simple;
        q=dns/txt; i=@ericsson.com; t=1531856975;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2qQMLdU1QYcT1Ux85X6w/XEWDU1mYm5tImzW5ljzOH4=;
        b=M0gWREdenFwB2UpmUf3d40Uum8jntgV+Vmjsu4EhpmhpcZoAd7BCGA9GiTgTK/Cz
        xayJow95KmN1aRNer8QqvwbNQIm4lozCyNzZXW6ygYVOHQumBZLYo1kZyzL4V/yG
        26xL/EgkhOgemg8uXSG8o6fx066pMp/NaaMMxT6LDN0=;
X-AuditID: c1b4fb30-1dfff700000059c2-70-5b4e484facb7
Received: from ESESSMB501.ericsson.se (Unknown_Domain [153.88.183.119])
        by sesbmg22.ericsson.net (Symantec Mail Security) with SMTP id 8F.65.22978.F484E4B5; Tue, 17 Jul 2018 21:49:35 +0200 (CEST)
Received: from ESESBMB501.ericsson.se (153.88.183.168) by
 ESESSMB501.ericsson.se (153.88.183.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1466.3; Tue, 17 Jul 2018 21:49:34 +0200
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (153.88.183.157)
 by ESESBMB501.ericsson.se (153.88.183.168) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1466.3 via Frontend Transport; Tue, 17 Jul 2018 21:49:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dXuCuTSm8NZSJA7DcejwEmxgmvdcUdJb5sYs9NEHRU=;
 b=ViH4Z1/q6qqi80sUVIVPRj43VTKq96flBoB/6z2xJn33QS4KV5gfFHNJVcEl991aNNgJsza055D1cYMJ1v+D6R5ZP6xMBVbXTACLrPMFbu/ZwELbRiQOJKs4jzov0I/SOKvOVgOiIwiS01EOqUfQvl/IYKMhSqqqpgPGpNfmHnA=
Received: from CY4PR15MB1575.namprd15.prod.outlook.com (10.172.162.16) by
 CY4PR15MB1318.namprd15.prod.outlook.com (10.172.181.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Tue, 17 Jul 2018 19:49:32 +0000
Received: from CY4PR15MB1575.namprd15.prod.outlook.com
 ([fe80::dd16:f8c3:a7bc:2efc]) by CY4PR15MB1575.namprd15.prod.outlook.com
 ([fe80::dd16:f8c3:a7bc:2efc%3]) with mapi id 15.20.0952.021; Tue, 17 Jul 2018
 19:49:32 +0000
From:   Jon Maloy <jon.maloy@ericsson.com>
To:     YueHaibing <yuehaibing@huawei.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "ying.xue@windriver.com" <ying.xue@windriver.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "tipc-discussion@lists.sourceforge.net" 
        <tipc-discussion@lists.sourceforge.net>
Subject: RE: [PATCH net-next] tipc: remove unused tipc_link_is_active
Thread-Topic: [PATCH net-next] tipc: remove unused tipc_link_is_active
Thread-Index: AQHUHdZpKPIJNMbMbU+LS2FDFTbtD6ST0qAA
Date:   Tue, 17 Jul 2018 19:49:32 +0000
Message-ID: <CY4PR15MB1575D0F8F347B9A37A61846C9A5C0@CY4PR15MB1575.namprd15.prod.outlook.com>
References: <20180717135846.18600-1-yuehaibing@huawei.com>
In-Reply-To: <20180717135846.18600-1-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jon.maloy@ericsson.com; 
x-originating-ip: [192.75.88.130]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR15MB1318;6:pUq415a4CXDSF8S2krzi2sDs3xkSOUfSEW/ZrAxE9FzAqoKJPlJ719YDyggTcbE48LlGf8huH/uqgsSrBfjZntLdD5xSx2766JKz+FKewmTMbw0qsKp5W6bGqLLzfJcbqEpKDmUVuMlVWIWa4j6A23yen25Xu5KM81m8RkLeTXGemdVD/ZgA2Y02XtT+Xkgst8MA1OA09Sc5/aKck8AyIR1lKk0694deERAudspjRNbK7S5OEMm4cpZQnO5ZF2ze/Z9QQBada0EXvOy+82GKHGdaEPIn9TxsAKFmPHXV0AOMje7z/22TQs9nahN7yaXe9fJUND48FA6k1TedZRLjPzpcCiIIAio/gb+1heVT4u6vZonVDMOnBkuVbnkmIIIDZdWzgnnThpCxP+WfGKkL5nAvd/Xgin4ZMXvjlnSfzcKb3m+Q9iA4BjRVwA2eZzZYfi1vFk26f7MBJFwa9/UOqQ==;5:vrfId9RpfaB2kL6lBxVTq/qPc+Afp/siphQAL95b4EfPLXXCxCXPhm1WQubLbfELw+4sSB1ZGAkvRqcMnxm2EGSLkAnSAAWdCPmYLORY8MF9wAttqP/nIkNCTcyeNZ0HboTkUnbv0GbLu6ogHj4uxcJjzg/ydst580uTg+Xb8Ss=;7:+53tNbfieqScDxQWhh5bpBXpknbOmhS7+9iOxlqWIYSY9J0G67OgIjoDcoi/gPCsd0QnohPpUicOalllix0KaIdtm50rWpOQk31hlSQ/nnOT/Lxyg7PP9Ya+JirGIRLKPPUF/7Ou0WIJmrYjBUOpOQ5Pi1TkbVsXnwCKdXT3XK9B3nARRP09jp5TFS5QYikuABGdLKp+QAUw30Ez+1j7aySX30i/nr+fXsMFjjI6mgc14jcWcqqAk/MlN1Z347dm
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 5f587d14-2649-45f1-7531-08d5ec1e6a85
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY4PR15MB1318;
x-ms-traffictypediagnostic: CY4PR15MB1318:
x-microsoft-antispam-prvs: <CY4PR15MB1318F3868A1A64A76C6063669A5C0@CY4PR15MB1318.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(37575265505322)(143289334528602)(9452136761055)(50582790962513)(42262312472803);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:CY4PR15MB1318;BCL:0;PCL:0;RULEID:;SRVR:CY4PR15MB1318;
x-forefront-prvs: 073631BD3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(136003)(39860400002)(396003)(346002)(13464003)(189003)(199004)(476003)(76176011)(74316002)(345774005)(102836004)(53546011)(54906003)(2201001)(7736002)(6246003)(229853002)(55016002)(9686003)(53936002)(6506007)(8936002)(305945005)(6436002)(256004)(8676002)(7696005)(486006)(5250100002)(81166006)(81156014)(44832011)(446003)(14454004)(478600001)(66066001)(2906002)(316002)(110136005)(26005)(11346002)(99286004)(2501003)(86362001)(186003)(68736007)(2900100001)(97736004)(33656002)(6116002)(4326008)(3846002)(5660300001)(25786009)(106356001)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR15MB1318;H:CY4PR15MB1575.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ericsson.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0HnfFzMVwHe0D/lxuuBWb4F9pxVfTKRPLsRVrqFs9JcTcjJ4CqmZWoFMShO0FO91xWdD3XBFVbA78rGQqy68UlGsUQV04HxlVL2ARcTH4smUed+N6UtGgzlSbOyvEIbMMVKTFc7ptOiL7TZqMvswzGsV5fV831oKzuQC/0B8GjrkR7YT6UVJ19jXWeZyxNpD0e5Dnrmt7p0J03gdIbiFqIrTw/xj6apTxI1z2RdT8Nx0LFBzSrLfXrcBpL4K2cOev8B6MI7WGlszoxMH09BeiDUr2SgUSPX1CWfSy8s/JpGYlQo48zEU7aoVRAg4GF0Qpi7IuPfxdf4zxomnmau/uMnvsQqmmRHHo6stuNq/G1I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f587d14-2649-45f1-7531-08d5ec1e6a85
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2018 19:49:32.1727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1318
X-OriginatorOrg: ericsson.com
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHfXbv7u5Wi8fly8Fw1SCKla9EDdNQMB2GU4IitRdXXtScUza1
        NAkFQVELIydolit1mYSaLhQ1U3Pi5gdrokORylRkiWWZjigkt2vQt985//95e3hoQtTE9aHT
        1TmMRq1USSgBWXux+6ZfnFyRFDjy0l1WP1FCyiZ76ynZqN5LZpy4IVuw2QjZ3MYyGU7Jjc9n
        OPKSkVWuvE+/zpGvd4rl7cZXnHhuoiA0hVGl5zGagNPJgjTdYCXKNvBvWabNRBH6yCtHfBrw
        cXg0X4/KkYAWYRMCi+0Zjw02EVQsj5Fs0MSBN733CWcJiasIKFkNZIUHHGhpHKScggh/RvCp
        QelkCh8Be00ZcrIHLkNg/uLlLCDwOAJr/z2OU9iLz4DRYSJYUxTYNh+SLAfD1Ic5kp12CLq6
        p12NhPgS6J7qCHZYCFRWW1zMx6dgfeCbixH2Aoflhas/gb1hdrGBwx6Koal/gmDZE+wLW9xy
        RG/7E2B8KYFNH4Shng4uy75gbahwvQvgAR78WtLtCH6wptPt9ImFrZ+lFGt6h2D27dyOSQpt
        0w6S5Qwo/t5HOocBLoAhYyibFkPr3XmyCgXV/bcqy8dA3/eDYvkoGJ6sEHWu893BXLtI6hHZ
        ijy1jPZaZmpwsD+jSb+u1Wap/dVMTifa/jtDxt+BPci+HDGMMI0ku4XESUWSiKvM0+ZnDiOg
        CYmH0LQWmyQSpijzCxhN1lVNrorRDqN9NCnxFsoUXYkinKrMYTIYJpvR/FM5NN+nCNU1K4xR
        7eRlX9NZvrQBcuPMr1NPiEIiK2fCvc3RY1cM70MNhRFF9vg73e69+Q4r709/s0W1vy0mqzSR
        rHEL5VrPT4jVFw7ssuVNNX5Fk25bezoD9GHRyZ7dheceU6NhJQK+Jj7msIe0o7hgoyXSWrhJ
        CdxqxLG3qyUBK+VmCalNUwZJCY1W+RfuvrPGNwMAAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Jon Maloy <jon.maloy@ericsson.com>

Thank you for fixing this.

> -----Original Message-----
> From: YueHaibing <yuehaibing@huawei.com>
> Sent: Tuesday, 17 July, 2018 09:59
> To: davem@davemloft.net; Jon Maloy <jon.maloy@ericsson.com>; ying.xue@win=
driver.com
> Cc: linux-kernel@vger.kernel.org; netdev@vger.kernel.org; tipc-discussion=
@lists.sourceforge.net; YueHaibing
> <yuehaibing@huawei.com>
> Subject: [PATCH net-next] tipc: remove unused tipc_link_is_active
>=20
> tipc_link_is_active is no longer used and can be removed.
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  net/tipc/link.c | 5 -----
>  1 file changed, 5 deletions(-)
>=20
> diff --git a/net/tipc/link.c b/net/tipc/link.c
> index df763be..6987ffc 100644
> --- a/net/tipc/link.c
> +++ b/net/tipc/link.c
> @@ -297,11 +297,6 @@ static bool link_is_bc_rcvlink(struct tipc_link *l)
>  	return ((l->bc_rcvlink =3D=3D l) && !link_is_bc_sndlink(l));
>  }
>=20
> -int tipc_link_is_active(struct tipc_link *l)
> -{
> -	return l->active;
> -}
> -
>  void tipc_link_set_active(struct tipc_link *l, bool active)
>  {
>  	l->active =3D active;
> --
> 2.7.0
>=20

