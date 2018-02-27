Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1518274-1519736692-2-2172468194346021038
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='fr',
  MailFrom='org', XOriginatingCountry='FR'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519736691; b=nkZXyEbf/CSh29MSEN9j8scEDz3n6iC0qY+MFrvj2j4/+wi
    YKFoIBbujnRzoPkMxYPLBVPftHJlH0aVFb7/ySt1t2OeKvbjaT1SMVGSPDpjOls2
    LrDmUR6nxk2tew+H2clswTsoomVXDqTP/eA8tAzucTD0pKNb2KES5DhzKEEk8CXq
    ehEzktHZH3/Qb0/EPKJQV9qkBBRBNbUA5Ihcc/2GI6cK5vDfFyVTLJ060Raltbua
    4CNHGjNzjpQNHoDaJpQ7+52kErXUcd2etajfsZ/zNau1V76U8pz0QWcGEBM9/AOM
    8ZkeLibHUwMjowre8IYci7EOPm3rtVMAiCkwfCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519736691; bh=AcL75B0Tyg+sLTFzMlhPnDpC3h
    5tNV6Czab0FOTCNgI=; b=lfLKh898TxoBLvF0fUGeL8wODUj/WYw6MMbhgY0ZtJ
    Jecbs4/+iXUpJh1ViSLZ8OkNJZxlCV7TgKvDYJeapkOLAEcx9DbDRD00NcbIGxcN
    aK6JAd53MlUZD/aosGLqtvab3oy4Vkn45vK2HYn87aP8d1DdINOPU2shHDM0slDj
    Gcb12SuyZJ1/PAzTT57tzzQ7gXwRLJieXKtaUQRIA37YTp+4hkZsk5uEmFOzSDKJ
    cxVp65oZozQw3cegnAjX3oKlXM3eVBc78IH+WMIIhTCfk4IRme5xGg3OWEDxELmq
    Bh1ME8cwLnuImVaDWQP5sjbfIZHBGMCM/xeto7/ZGBVg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=actia.fr header.i=@actia.fr header.b=jz2zt5Je x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=actia.fr;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=actia.fr header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=actia.fr header.i=@actia.fr header.b=jz2zt5Je x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=actia.fr;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=actia.fr header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752260AbeB0NE3 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 08:04:29 -0500
Received: from mail-eopbgr30072.outbound.protection.outlook.com ([40.107.3.72]:4783
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752056AbeB0NE1 (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 27 Feb 2018 08:04:27 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=bassem.boubaker@actia.fr;
From: Bassem Boubaker <bassem.boubaker@actia.fr>
To: oliver@neukum.org
Cc: bassem.boubaker@actia.fr, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cdc_ether: flag the Cinterion PLS8 modem by gemalto as WWAN
Date: Tue, 27 Feb 2018 14:04:44 +0100
Message-Id: <1519736684-29586-1-git-send-email-bassem.boubaker@actia.fr>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519732192-29332-1-git-send-email-bassem.boubaker@actia.fr>
References: <1519732192-29332-1-git-send-email-bassem.boubaker@actia.fr>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [212.194.216.83]
X-ClientProxiedBy: VI1PR0902CA0005.eurprd09.prod.outlook.com
 (2603:10a6:800:d7::15) To AM4PR01MB1875.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:c::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edf41923-ed18-44bd-2c01-08d57de2a015
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:AM4PR01MB1875;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR01MB1875;3:wom4EIULj3y9/v56Hy7ZZw4MnQI2pBsXdPCK+ppsmp3r2hMwg447peI9uuGejNMYUy9H8CDIdln4GXLDp367zl0c27CmLmweIEbmcRva+D/vs5BsPhN9SrCQyUhgRqy75Y9j/CxciGscPHuDOZyS7VeUAPyxxvPS48U7EdopQ1A5biz15iXCiphhdSQd8BHzFGf6J1ErbsFHQ/MkLS6ngmBHonFto6m8O1AOh/jVIt/sV92+dLGIIsIbANGHuT98;25:16T3QdGl04Rj4wQ9xF1npcXX9H8VoIvh/q1XZd1D4rj6LV7Nx00DkEfaLxDkvEA+SreNsfjOu8xXC6uVu+tdw3XCPPMhyBLt9P/MHwK4PBOjplRPpp9GzGncMBkOqF2lxUrNMSKjQtX86OX70A1i+lHy8Up2iDw5YMm3GsihQ/rxN5nFTd+faInhI7L4y5qVncmUhhutLCDmDdCK0wg379EmfnthqNahpqNis+/Jj/uYEQjpX7aKY+UtI00A/SqaflhXd9e3Roddky5ochqnmX74dTEsHfr5zPbpvMEhnEHPWAqtCrTDkIUGJ0jysqdZKV4rBUiiqIiA64+MJeEHCA==;31:Yf0K8xt5m5BY4ukXGdQ0526Y51p9aIA85qsXHw4oTxAshhbu0+Hlv1jfjODQGZdVL7tDL2jtQhi2vxZve5wiziEOZSSnnqSWlWeWf68ZGFm+yCIVch0ZYPoQFugjzotlQmfxX5lwya9ewpv2cFbO4TAE8dN5XLSywotQPkRpsuDG9hMAfAuNoypx+TQYjV8qtbciuJwr3CWsFsidyw2OJAkTZTR5ss/Qpe45vLBRJ84=
X-MS-TrafficTypeDiagnostic: AM4PR01MB1875:
X-Microsoft-Antispam-PRVS: <AM4PR01MB187517453B0579F2E2AFC4019CC00@AM4PR01MB1875.eurprd01.prod.exchangelabs.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231220)(944501161)(52105095)(6041288)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:AM4PR01MB1875;BCL:0;PCL:0;RULEID:;SRVR:AM4PR01MB1875;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR01MB1875;4:BN09pMRdBssd+obDzFeKmpEMeHpN9wsE2ADNlOSK3n8tqj6cXR94vEhUg/5Iz0emjYZ1CwY9S7a4xTykWfjA91Nz4+f/WtGgoO/2UMWCL465eSRagIjWxyKqrvuanydU6wPYKceXowZAwWEwBzJK++ndjT6J2D9rp21vHM3ho9A2u2A/pAzOpUCm0LB+1dtN9k2wNUq32N+kgONB3DtqVHe0txUZK46B5cuSUYNrBpIthVze8RuB9YwLlRU+Z3bU3hQjvpz/tVmZkW+fFGgSxA==
X-Forefront-PRVS: 05961EBAFC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(366004)(346002)(376002)(39380400002)(396003)(39850400004)(189003)(199004)(4326008)(6116002)(3846002)(25786009)(2906002)(47776003)(68736007)(316002)(16586007)(48376002)(50466002)(74482002)(66066001)(36756003)(6666003)(2950100002)(6916009)(6512007)(8676002)(2361001)(50226002)(8936002)(81166006)(53936002)(81156014)(106356001)(478600001)(5660300001)(2351001)(6486002)(7736002)(105586002)(1857600001)(305945005)(52116002)(51416003)(86362001)(97736004)(76176011)(386003)(6506007)(59450400001)(26005)(16526019)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR01MB1875;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR01MB1875;23:QASFWgs4+gwaiWgIXSs6JZ0FxNXmkPoOzuNpbp/zp?=
 =?us-ascii?Q?VVSHmzJEDZwpnXQcRkpviXWS4gU37G1kKxGYyrymhPPL7Ryg4Ac2ehBbNXey?=
 =?us-ascii?Q?Y4cEmHsUGU3LsxQrsguf/HS34e2Geam+sWgjjWOcm2jOjAj7RC0tCvYiOmpn?=
 =?us-ascii?Q?L2Ay83EG70wjSCk4xe8EAGVexluSkYxRVBkglTM2idHHidBDx26wH5LpuyVT?=
 =?us-ascii?Q?bzpoKx6ssNFxDBYTWNS3rs2rBJSs6DE8SlU10AP/2248GtCVPV9TkU6wFy8P?=
 =?us-ascii?Q?lE92IPbCYm0rfNOYb8Ab8s7j4+VcJIJM03lKruIJyliOF0o6CaQNi4kE8a5V?=
 =?us-ascii?Q?3iIdZR18kEChm5y39lr+lKGP4x6xGG0AujguOFi+vjLv7GdC+2J5sAznnLmA?=
 =?us-ascii?Q?Kl7MyHTd1FSM65ITfIDiDjmEKaD8KcaY2wEvs9x1fYWSZ6ifvzQRFkqL0Whe?=
 =?us-ascii?Q?XHaVqQsoj1YC8Rhqxl1v/TR29eU29ARVZJ13L4bUy4e2pUEjTC6UfBbWxDEV?=
 =?us-ascii?Q?8sQmAHQZ8tsta/ReeQjw0hT5MsXR1kv3/IrOpwxqJzagauaYGPm8u76Y8K4M?=
 =?us-ascii?Q?83gmu3q8ricKzc9iV/md3uWFt5bjH18eXg2qSOmj9EFZddAB31f+ROg36SaR?=
 =?us-ascii?Q?DuiQhwnqX80OgDWrld8emgVhNsF5or3O1mbVFTcTdF6zb0vmHeIZjdNK+i73?=
 =?us-ascii?Q?DKtxnQUIg4DYE/LH+9vgB1/bPlb1YyEqZNwupKj5OoYUQQPWxemUoIVqkPBY?=
 =?us-ascii?Q?eWiCiJyv2Wy0nNrbZmQW7NhlZfiqYImNfBBJ1Jzhefg7XLVfAgKFrSkthNJN?=
 =?us-ascii?Q?fmP3Vdi8pisaYdE4GRG6PHh+gM8xAlQX321lT62FDbwZd/JxOVZ2LLRDRtmr?=
 =?us-ascii?Q?usoOm2PkjUXEJfW23IF51Sj9e7CO7GUfq8zfJxJwzQakirEDZC/ArXTHR9GR?=
 =?us-ascii?Q?jmT4w324I8jhy97tivVjd4yCn9wXpY3sWp+zkTClN+0/xX36D6UUMD9quSGl?=
 =?us-ascii?Q?88h+bJIYgNr7C7+dUxRKp3VO+RkqCpmMgHGuCg02bDEe29fqQjpGznANy7P3?=
 =?us-ascii?Q?gXiGpqzmFt56Cc/PPbeNbEy1xpyQYe1VxrkbZAMpgsSbpCYgLNFDEmz/fuCD?=
 =?us-ascii?Q?CE7k4wLbv3kqIEBHa9wkCpXBpPIsyQXcT1IWgZ+j7tC2mIAvPYL3oFuak1oB?=
 =?us-ascii?Q?xaPy1tCvTkbL0Asf6OB2yYpVHbWcguCjzmxhPNQd7ogP7OsmV/YjVIDHQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;AM4PR01MB1875;6:tOssyPOBfjH/4elh43NXOwogzvrSHc8J7JJQ4T0EVNwFwWC26a8xTBl5z9w9sfh9jdQ1OCQwhDyLm/Gr34gqMG7OHKNkmKTiwXILh5/sFRY269rWR11YUB/0TvTAa5IoUw1OZccdqGs8GU2mQXMVGeg+Zvrx1lNnTeGe05Zf5gaLs6NilDVExqtpePCaqpi1u6w/DdgLVzr4fjUmN7Fuvc08Dq29IJOecKHWctet9MM+mywk6S7UfxNZqUmWaz0DBUgHfIl2xjnr72Wo9ORa+Pwo4ufaRl4moft0dKIldC1IU0hTEYe8jDQh0SzaENggedkRhFsahESoXxiks9rForYBnXT6BLdh7IKPFQ/XXY8=;5:y/MyyVbW/maO5hKE+H/p+t25/1NdzYXPn+0mfnnL6/g2JksNQ1zIdb2MLQBXMBf7buTgb01ZAtcVp0QYPoLxd5oZYKvDtiEke3UXqDEUw0WPhkSAZRdTFj2vTr/rOG+YsTRvRl2sC2xQqZekOurICy86WLCWmHNfvsSTblqQYl8=;24:PAZ0f+Rp0Kb1RQpAi8Ed9yczYqYE2kvltttHXTLzmjqMaLWyHCnfv54ngYj7VBi7lySEkchjp/IS9DYkMm5quggyOxe6rcdEim/jHvIin2g=;7:DhabIiPcmSh9u4h/hWPBQxZkFR0mYQ+3jqSR3a5bw6zpibeiTS2YnwJrlvYi4t7WvbidqQofvik8NQSoJYHHKU2IuBPTgQtaSALyuvgTOXEQVVR5DDho+v601Xim7Cl+2OJfo5fbqN/KA74lmXobLwN6S19NCyMPpOKSI70jn5XxsLHizTXvSVDYWs5iGLNAwThfSUBdIYSL26V6YWj8G3MaZYs0DYD/XS8WSPcVpihfiEXcpZk6zh64V9Kcw42H
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: actia.fr
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2018 13:04:24.0240 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edf41923-ed18-44bd-2c01-08d57de2a015
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 86314f06-03e8-4460-82f3-a44f992a19c7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR01MB1875
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

    The Cinterion PL8 is an LTE modem with 2 possible WWAN interfaces.

    The modem is  controlled via AT commands through the exposed TTYs.

    AT^SWWAN write command can be used to activate or deactivate a WWAN
    connection for a PDP context defined with AT+CGDCONT. UE supports
    two WWAN adapter. Both WWAN adapters can be activated a the same time

Signed-off-by: Bassem Boubaker <bassem.boubaker@actia.fr>
---
 drivers/net/usb/cdc_ether.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/usb/cdc_ether.c b/drivers/net/usb/cdc_ether.c
index 05dca3e..fff4b13 100644
--- a/drivers/net/usb/cdc_ether.c
+++ b/drivers/net/usb/cdc_ether.c
@@ -896,6 +896,12 @@ static const struct usb_device_id	products[] = {
 				      USB_CDC_PROTO_NONE),
 	.driver_info = (unsigned long)&wwan_info,
 }, {
+	/* Cinterion PLS8 modem by GEMALTO */
+	USB_DEVICE_AND_INTERFACE_INFO(0x1e2d, 0x0061, USB_CLASS_COMM,
+				      USB_CDC_SUBCLASS_ETHERNET,
+				      USB_CDC_PROTO_NONE),
+	.driver_info = (unsigned long)&wwan_info,
+}, {
 	USB_INTERFACE_INFO(USB_CLASS_COMM, USB_CDC_SUBCLASS_ETHERNET,
 			USB_CDC_PROTO_NONE),
 	.driver_info = (unsigned long) &cdc_info,
-- 
2.7.4

