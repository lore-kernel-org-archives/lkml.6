Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523240310-2-3561146973035744055
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523240309; b=CXjr4PcxakAmVZTxWDYZDBFGivE6Q/net7nlMtu9pnLfeDvBq+
    K5NEe3gz5+CJCGgRETc9CvCFmoOz/HZ5k1i69sJf3TfZURktosZbFCtBbtK3nEsU
    KP7gzZ37EuBX3ognlZsvKsgDtZaOOKfFKc2Ea677BieN72Qg2kDPUatdRZD8EOrR
    l80U4hC5Jebr/0qlaml0RnjRkh0po8l5ajxMJeY3te0Oy9Doa4+RrvV6D8oEWpyH
    c72aWMIDtLoaAItNHaWLNOsad2nWWFGLFPLPVPvQbYOifugvVC6ILOTz4afzjbKi
    mnZnOuAx5Mn28FDYejg8iOnFP15I+Gww4AEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240309; bh=qFZ8n2jHjm
    5tcAdD52VgAqKHNRH7kgW95kBIABH17JU=; b=BmIx3+R19Win6ZckGboae+N+1g
    UxnsPtah0fbPG+JGm4DAeZwgBQ7hFlCHBKYdtC5CVrG2/+HtssBAxIVLgEjFL4Iv
    I8isldadYttA3wam11NGjOyqqt0aBiupDph5O+Fj4igtMm3U6uul2lf6TNLfjOTO
    nKI2vB+pTE1mLbP/JM9nJ1Y47LU3v+lNBaBj5XJj/z8b7P2FMORwWpnKKue9TXxH
    xxWiSg3UGOPzTpewqxr0EMihnCg0BvzHm4FvKPtoH+XqZlSS7c3+x8hkK8EzzwEu
    lSQjyB8oMmOxTrp9aa56v6RNcZsJGQ4tF2AL18zf/u/nNbTBhHEGMhTEqa1g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=M1fBgefp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=M1fBgefp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGjJ2/UpjuUsznGiq2ogEoaTv/UMCa7u8xTYt6diR1eg4Uq4+RyAWxjx5byM6c1J7RtPIHG1xlTbYYsTyN75VdA8HfoYqjEKM6TDvT1m1sUiBJDJ0Gdz
    qT6b2gIjz6UI3He+JeyPpb/7Yjq6Zx5ixKZE5FZLahh9m/j8PzlBOi7E3geIrTbtslckGcDypvhjTX/5+NswbTbmI5xoNfxJIlTMWgXmEKijXQpANxp22abM
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=SGkhBHntHi_B7jzTMtcA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757894AbeDICRk (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:17:40 -0400
Received: from mail-dm3nam03on0104.outbound.protection.outlook.com ([104.47.41.104]:17478
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755657AbeDIAa0 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:30:26 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 133/293] iwlwifi: mvm: reset the fw_dump_desc
 pointer after ASSERT
Thread-Topic: [PATCH AUTOSEL for 4.9 133/293] iwlwifi: mvm: reset the
 fw_dump_desc pointer after ASSERT
Thread-Index: AQHTz5kjBR7/Bc7o7kKYdtryYosB+w==
Date: Mon, 9 Apr 2018 00:24:36 +0000
Message-ID: <20180409002239.163177-133-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0807;7:2vfOyOiIe/iooAoxhPzEgGyxiuvB7BZ71xuxfISrLhoGs2G+gQd8OrTj0HgEDFM39xmiZ0vrtxQ+1kGZwr2cDYm9Jlo2zv+Ga/eCVJYYN7FRTAR2pyjmCJvHVHdNt55P0YdV6qZR1cNieqnib70x8RyIRHemHFbx9Ty0uHLrmyN+iv2iEkkkDsp3l837v+nt28yxIo383j9q2oSsZkkf4CvZKjrG7oIGsNHzj2bcY1/Y2MXkRN/y+lsqP7ukQpMw;20:e9I3sANogwnwC88+xRdMbss6cGDeVFAwegWBuzxK+EtA9VakWpSZSl7OtDdjHYesdPeCTUavgqzQO4Aq1wCSR4NwzZ4YrhHh+6GCy86LD6MX0jCzAGn9BsTrJj6hDsm/Jo+C/TeWamlRdwYvOipMt2L7WJpwQLhVm5wmYkmZTwU=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7550288d-7eaa-4db6-3aae-08d59db11490
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0807;
x-ms-traffictypediagnostic: DM5PR2101MB0807:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0807A918CA552110030274EBFBBF0@DM5PR2101MB0807.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0807;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0807;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(14454004)(4326008)(54906003)(25786009)(53936002)(2900100001)(1076002)(3280700002)(6486002)(186003)(2616005)(68736007)(110136005)(11346002)(10090500001)(6116002)(107886003)(3846002)(36756003)(8676002)(72206003)(22452003)(66066001)(26005)(6512007)(478600001)(3660700001)(81156014)(86362001)(81166006)(86612001)(7736002)(305945005)(8936002)(10290500003)(6436002)(105586002)(6666003)(316002)(575784001)(76176011)(5660300001)(476003)(106356001)(2906002)(6506007)(446003)(2501003)(99286004)(5250100002)(486006)(102836004)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0807;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: TBFdoo6FozULUHs7HUzPjAf9WUMly8IOJUdU5AnVmryozfTYjXy4P83O6hO8zqzp107/iWMrz3JTpPp1390JDlASouGT0C9nqieTPaOLvJxLNZFZtD/mfDJyHiCxCeiHPDf5AF2lck9JogFJ8w1R/xhvHCODiKtG+l+iePOSoP1S7ZMdw/QKKM7wJY/E6sdGLqzyQJWK3BSBXdjWx+P2rzh74QbnilhMlM9etWuIhzEUBO7JQQEnWXyFihxdE9ocjtNz4mhV148p/9jxjXcH5HCVp9uX7uRCLW47CkBp5yQkuUNiiibbYnzhdD1aV9yMw4uhZtQsiIzBcmf5SMk+TQDwZnxK5WOtsKYbwX9WKtQlNlc3cubFUt8F/JOerlpYkI16EO3tY3R6AEgWkY3vhlU1iKtp67rUJVT/tFWQtwA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7550288d-7eaa-4db6-3aae-08d59db11490
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:36.6125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0807
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

[ Upstream commit a509a248bb31ea013c4c2b6801297a2d82eecd43 ]

When we get an ASSERT, the fw_dump_desc pointer points to
iwl_mvm_dump_desc_assert which can't be freed since it is
a global. We still need to NULL'ify the pointer when we
call iwl_mvm_free_fw_dump_desc otherwise we will hit

int iwl_mvm_fw_dbg_collect_desc(struct iwl_mvm *mvm,
                                const struct iwl_mvm_dump_desc *desc,
                                const struct iwl_fw_dbg_trigger_tlv *trigge=
r)
{
<snip>
        if (WARN_ON(mvm->fw_dump_desc))
                iwl_mvm_free_fw_dump_desc(mvm);

Fixes: b6eaa45aa18b ("iwlwifi: mvm: add the cause of the firmware dump in t=
he dump")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw-dbg.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw-dbg.c b/drivers/net/=
wireless/intel/iwlwifi/mvm/fw-dbg.c
index 700d244df34b..bec32cd0be76 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw-dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw-dbg.c
@@ -331,10 +331,8 @@ static void iwl_mvm_dump_fifos(struct iwl_mvm *mvm,
=20
 void iwl_mvm_free_fw_dump_desc(struct iwl_mvm *mvm)
 {
-	if (mvm->fw_dump_desc =3D=3D &iwl_mvm_dump_desc_assert)
-		return;
-
-	kfree(mvm->fw_dump_desc);
+	if (mvm->fw_dump_desc !=3D &iwl_mvm_dump_desc_assert)
+		kfree(mvm->fw_dump_desc);
 	mvm->fw_dump_desc =3D NULL;
 }
=20
--=20
2.15.1
