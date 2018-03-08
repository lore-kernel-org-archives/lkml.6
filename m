Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025811-1520487481-2-7519282576417829239
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520487480; b=pJshbCQxdFuq/zpNiV1HoH+IuBszi2PE7WVeC89LAdzh3c+
    jaei1mf5pZDcd7RXIJsAkCOMYLSVjKLwbgQAYE9/dnJgMC2JI7xByTyMNkUivQVG
    fQbmHxxCC+14xATQVm3suGno5behDg+KqDd3cXlTAPGQniSxaqjc4NW4Pey4VqTD
    pmOmAs3Cc1/qu4cUMebKfk4G9JPDYof2kSNaKwILAcF/RLEv74k176ZtfTidxGYf
    HvG1B6vsv9ie6LooCQ2+TQpuXC2wB8LYkgD3Y1Vl5m6BUHKObtyf/4BkzwGzUWOB
    47oAqbDk0FAGBJsnQY3qyyaLD/bIAFPrDH2I0Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487480; bh=nk+ACg
    pJjl5wMkDQa5tRUIulNj8EMYPhEk9JBMYLbtg=; b=cosmV9eEzWNnZOtf5ZH04Y
    5tgnT9kEIV1D9MZMbasOj63SEK9NitBBR32ym55eAJD2MQ4rfS5nE/QZtwZWoaXK
    eY5imZ9RhQOSb3EaR9D1OMkniX5FwwkrPi/W8w3I2Ip0HlBYZuCvKI+q92vpjRJh
    1lBVdWL8fPzBqR/PKMQRnAj73Yt/ZbzXnXzu5A3gez2alcBS36DvPTqGZ4ol3SSs
    Kp64pK23A0ZwF5OSyoXzS+BG3zmvO463gLPLNMwX+KhYDKchf0eJyqKbT4gd/lPs
    jwlVGHh5s0yN+V2tfCs2R/XqJwhnHe/5vEnzH0is1797ZSuu1ccmkF5leRS5vknQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BYAHr5Gq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BYAHr5Gq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966293AbeCHFFy (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:05:54 -0500
Received: from mail-cys01nam02on0093.outbound.protection.outlook.com ([104.47.37.93]:7384
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935211AbeCHFFt (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:05:49 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Guoqing Jiang <gqjiang@suse.com>, Shaohua Li <shli@fb.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 031/101] md/raid10: wait up frozen array in
 handle_write_completed
Thread-Topic: [PATCH AUTOSEL for 4.4 031/101] md/raid10: wait up frozen array
 in handle_write_completed
Thread-Index: AQHTtpqJnmNWtgiUWEiPFzmbY2c4lw==
Date: Thu, 8 Mar 2018 05:01:37 +0000
Message-ID: <20180308050023.8548-31-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1046;7:iYBWTU5uhF/36HTmhv7oW0Ywa4ueSESYmEJk/gqZ5nZkuLZ4XF9Y8kJuogL6yIkB0vfQ5hBXafZSV4NKBX/xylMe7DsZOP7LRviw3ho0h6q+YKggPS/J9qLGl4wjZUWIzaojHagkBnpmKqV/s93hKgP+D2ABI9xr3HuBlLX9aGeBVF4mj0hybcRshclDaMbn5mHYHsCvPlR3mRKQmyrD34cQI7A/R7gnccJA6H/tSakIgrsAqtnYsX+yTOd6ZLXA;20:xS0IRGy0d0hyAoS5UlN+ET+2Dd7+QBrIYbjGwcRSb3/kdKiP4vBiYYmzzSeg4SxLya0UDyvZwurluBZn6n+IntyakwbKDCJR8qbhfdydOT7fbtZxpFa21E5tApyEUu1SgArlG7QJPLIpPk92EmGCkWLDAXXTHU+YWNZIOYwkgLc=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8cd6b81c-85e2-4daa-a601-08d584b24161
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1046;
x-ms-traffictypediagnostic: DM5PR2101MB1046:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10469F2BF838597E738BFD48FBDF0@DM5PR2101MB1046.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(67672495146484);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1046;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1046;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39380400002)(39860400002)(396003)(376002)(199004)(189003)(6486002)(53936002)(3660700001)(5660300001)(6436002)(6512007)(36756003)(3846002)(478600001)(105586002)(305945005)(6116002)(1076002)(2900100001)(72206003)(3280700002)(68736007)(7736002)(97736004)(22452003)(14454004)(6666003)(2501003)(106356001)(10090500001)(10290500003)(2950100002)(81156014)(25786009)(54906003)(107886003)(59450400001)(76176011)(6506007)(2906002)(110136005)(99286004)(26005)(186003)(86362001)(102836004)(81166006)(5250100002)(4326008)(8676002)(86612001)(316002)(8936002)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1046;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: gn5Xafy4YqR5RL8WpTtofTQkGqZh7cuxRGyV0aiDyiFMcggJ+qZy0ttc54NCxzxuMGj8IAzK1vIPn15YigzuwcBHtFAJbJc9kXl6WY/c8FApM6ekYByWgH321sfw3hNgZWmb42P8VFNh5RupflMJoNxXiqQgxHaJ7Iar4VxABPkC15MuMkF8/1epdQXR6tACe2wjY8y9C2BAwi5Xwgx5rRoOkrofxQ02QJMpQFcxVmDeDaOLzDM0A5s1tO3+Bp9nHupwIEACHdJ+T8Tk3tcPdrXJ2VqowxRVXstk0O4n/JGwJ+N/E8y/9/w3+ENbXc7aakHfhMRHtNT4/1LynSXj1A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd6b81c-85e2-4daa-a601-08d584b24161
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:37.4833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1046
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Guoqing Jiang <gqjiang@suse.com>

[ Upstream commit cf25ae78fc50010f66b9be945017796da34c434d ]

Since nr_queued is changed, we need to call wake_up here
if the array is already frozen and waiting for condition
"nr_pending =3D=3D nr_queued + extra" to be true.

And commit 824e47daddbf ("RAID1: avoid unnecessary spin
locks in I/O barrier code") which has already added the
wake_up for raid1.

Signed-off-by: Guoqing Jiang <gqjiang@suse.com>
Reviewed-by: NeilBrown <neilb@suse.com>
Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/md/raid10.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index a8a86d450d76..05548af8df6f 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2698,6 +2698,11 @@ static void handle_write_completed(struct r10conf *c=
onf, struct r10bio *r10_bio)
 			list_add(&r10_bio->retry_list, &conf->bio_end_io_list);
 			conf->nr_queued++;
 			spin_unlock_irq(&conf->device_lock);
+			/*
+			 * In case freeze_array() is waiting for condition
+			 * nr_pending =3D=3D nr_queued + extra to be true.
+			 */
+			wake_up(&conf->wait_barrier);
 			md_wakeup_thread(conf->mddev->thread);
 		} else {
 			if (test_bit(R10BIO_WriteError,
--=20
2.14.1
