Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523243580-2-3812029238658997182
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523243579; b=c3EYtIzh+XUbFxHdTY/pg1PgLM15KXEhHifefYtHvyJaRZ1ILA
    7D6ms79Kjapi7RC1GEShFJ297HjAPIeNUebFXQSsM1XMf9fn9k63eCYUSvpGKgRf
    8+HI0PXvfEPww9rDx5w39E/exl/ghzwOlmOKR4hJIzkMqNdF0HFSgfJgPaxan9dF
    roFNCzEDENa26I1nvoFdt7EVY+QH00FcmcIlCWpNep7u17qDecBXRGtqHY8kQF+s
    og859LJfMPg8n9D5LlLoF77yZ7DqXwoveQZnBaAxW72Rix6ydPUGJIeUQHsP+rDb
    POEiS4+6KiPLxSoq/hfrPeCnpyOXKNnp8i/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523243579; bh=19ekOJhaoJ
    VctcLj3EB29G0NtaYS67uAEk/j3Q8faEs=; b=A8ZMeB7KXsvf0Ce6DxG7CDP2Z7
    kwEaslIRsdVpeMaYB4ae+OR9zpxctVq5cpyXuOr0qUCouG0sJBsDcKOI4Z5Hb0VV
    N0rqzjFi25FroiEe43H4Ur4P5hMg2lrJUSBM5C32Ligisr8hGbXbdjnYeaDcjdhU
    lXuehoZyH0U1vNhZZeKdOsgXAm0uqlvXH0BF/6VnzLuF3sqQ6g2k3xR1r++8t52k
    wlmu7FBSAaHqgvhGozHlrayzO4/167gipKakgUytWsgKzheZ0Svi91MFiXUiMMmp
    Ch5oXVcZLr7AuTFspXMgYHTgzNlqacveLlqt3F3rxXTsuQc5iUjv55l3D0kg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MBev5VED x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MBev5VED x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH9zbRSrIV/H5e8GgdnhxUwRoLmClkpjCjo8tsq8iv5857hmnfJn0x5yh4AIvjrDQ5pnqnqL3YUgMqb+Dm1LPzz2drktSoWXowx+MYHruRfQWI/6HIkw
    PgvT+I09YLhLMhB2g5Kr7kWLEA5emgaFv+7i5iXryva8s3CJOOOycWHcnapgQUKZmsnHxVXqUEl8laTzCfF3OPfRDOKrGJOJPUTCf7SEt4c5IcarnebdgoRf
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=gVGD3344AAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8
    a=Hb0Uqtfb04O3FyaSReIA:9 a=wPNLvfGTeEIA:10 a=xQEvYfgLW3QvObN0DhJi:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755222AbeDIDMz (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:12:55 -0400
Received: from mail-by2nam03on0115.outbound.protection.outlook.com ([104.47.42.115]:29467
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754045AbeDIAXw (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:23:52 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Daniel Hua <daniel.hua@ni.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 073/161] igb: Clear TXSTMP when ptp_tx_work()
 is timeout
Thread-Topic: [PATCH AUTOSEL for 4.14 073/161] igb: Clear TXSTMP when
 ptp_tx_work() is timeout
Thread-Index: AQHTz5iaKnH7xoeNa0KajAQSCzUPkw==
Date: Mon, 9 Apr 2018 00:20:45 +0000
Message-ID: <20180409001936.162706-73-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1080;7:czYtzunoLFeWNomTsyru7U2q5LgeQO6TD7R0hpE8SkwbvdFK4EJR9KivSfLrD9CjQ/tKKmS1BwSbQqM7w1ICShggdkGjKTDctvY4+GOdl/oZelj3QVOqNgQJiSIbLoGNXOezEqCykBcU+IXn9u9y2hfC6FkZzcS/yeOnViB+GVm1zEaI3Xc9/2iGzYPb5fPe99DEykR6nAm8xJt2dNtuCh/7SpwF6FC+144XaibDh2SbGlwpkCVYY1Ek5QdjNRUE;20:ZuWosHw+L87WkjyAgjp/aGUL9FzozF66dykhxxeSCUYtjFZlI7bSTHZZDu3ahKX/ym3G13xRaiXiiTSFx9cqz4/EFrZaaS6D8chsgJWDUC6YJnBTkN1NaDLfonWF3uhtE+v8yeNlI2JtM74NqDdSLqh5M/st6c2ee3/Xpo3n+Zc=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4e56b032-f66b-4413-923b-08d59db02a0b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1080;
x-ms-traffictypediagnostic: DM5PR2101MB1080:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1080275D1CBB525B6A37D4E2FBBF0@DM5PR2101MB1080.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(21532816269658)(228905959029699)(145744241990776);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1080;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1080;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39380400002)(366004)(39860400002)(199004)(189003)(2501003)(5250100002)(8936002)(10090500001)(5660300001)(3660700001)(446003)(107886003)(14454004)(36756003)(6436002)(476003)(3280700002)(2616005)(11346002)(4326008)(6666003)(53936002)(6512007)(22452003)(305945005)(10290500003)(316002)(102836004)(2906002)(6116002)(66066001)(6506007)(3846002)(7736002)(486006)(54906003)(110136005)(186003)(72206003)(26005)(1076002)(105586002)(2900100001)(6486002)(97736004)(478600001)(81156014)(81166006)(86612001)(8676002)(106356001)(99286004)(86362001)(575784001)(76176011)(59450400001)(68736007)(25786009)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1080;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: eJGkm1XKprK4TYYgAt8IwhoWaJPatBzaUwt/hwxXEL7nE5lYImX51lRoZoMNsW0bCvZ7sXFLPhYI0/7ks/ZfhDpoSsttQOjn4tU3cjXBUW5qWjIp7oKvC8MABM0dtLIAjX3a+p6RIVxGoEahLg24wIeXSATA9dHxfN4Dhue8VJBesTDYlfe3h24x36ptMINGhPKCd8T3D5phi/uMMZZoP45eKBpOoUkD/vtPk0+w3bZI+RKkRKVwqQhBqiJ9Ecj1w5/kgvcUJL6vMUY/C5ss9A2NnKtOzMZKvSlkdQ3MnpavaqnVY1D4mzAG6dAgAaRidcOYK141IvWMNJb0BIAH/wygD5oGfcbQUp8gNOYInrP8Ffp3uhgVfrab1aL1D2W5PCY4vtlYrjNCWtmw+xS0g6YBCIFcqIloSM58x7P9mGU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e56b032-f66b-4413-923b-08d59db02a0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:45.6909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1080
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Daniel Hua <daniel.hua@ni.com>

[ Upstream commit 3a53285228165225a7f76c7d5ff1ddc0213ce0e4 ]

Problem description:
After ethernet cable connect and disconnect for several iterations on a
device with i210, tx timestamp will stop being put into the socket.

Steps to reproduce:
1. Setup a device with i210 and wire it to a 802.1AS capable switch (
Extreme Networks Summit x440 is used in our case)
2. Have the gptp daemon running on the device and make sure it is synced
with the switch
3. Have the switch disable and enable the port, wait for the device gets
resynced with the switch
4. Iterates step 3 until the device is not albe to get resynced
5. Review the log in dmesg and you will see warning message "igb : clearing
Tx timestamp hang"

Root cause:
If ptp_tx_work() gets scheduled just before the port gets disabled, a LINK
DOWN event will be processed before ptp_tx_work(), which may cause timeout
in ptp_tx_work(). In the timeout logic, the TSYNCTXCTL's TXTT bit (Transmit
timestamp valid bit) is not cleared, causing no new timestamp loaded to
TXSTMP register. Consequently therefore, no new interrupt is triggerred by
TSICR.TXTS bit and no more Tx timestamp send to the socket.

Signed-off-by: Daniel Hua <daniel.hua@ni.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/intel/igb/igb_ptp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/etherne=
t/intel/igb/igb_ptp.c
index 841c2a083349..0746b19ec6d3 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -643,6 +643,10 @@ static void igb_ptp_tx_work(struct work_struct *work)
 		adapter->ptp_tx_skb =3D NULL;
 		clear_bit_unlock(__IGB_PTP_TX_IN_PROGRESS, &adapter->state);
 		adapter->tx_hwtstamp_timeouts++;
+		/* Clear the tx valid bit in TSYNCTXCTL register to enable
+		 * interrupt
+		 */
+		rd32(E1000_TXSTMPH);
 		dev_warn(&adapter->pdev->dev, "clearing Tx timestamp hang\n");
 		return;
 	}
@@ -717,6 +721,7 @@ void igb_ptp_rx_hang(struct igb_adapter *adapter)
  */
 void igb_ptp_tx_hang(struct igb_adapter *adapter)
 {
+	struct e1000_hw *hw =3D &adapter->hw;
 	bool timeout =3D time_is_before_jiffies(adapter->ptp_tx_start +
 					      IGB_PTP_TX_TIMEOUT);
=20
@@ -736,6 +741,10 @@ void igb_ptp_tx_hang(struct igb_adapter *adapter)
 		adapter->ptp_tx_skb =3D NULL;
 		clear_bit_unlock(__IGB_PTP_TX_IN_PROGRESS, &adapter->state);
 		adapter->tx_hwtstamp_timeouts++;
+		/* Clear the tx valid bit in TSYNCTXCTL register to enable
+		 * interrupt
+		 */
+		rd32(E1000_TXSTMPH);
 		dev_warn(&adapter->pdev->dev, "clearing Tx timestamp hang\n");
 	}
 }
--=20
2.15.1
