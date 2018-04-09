Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836577-1523239716-2-12789910232531347054
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
    1523239715; b=BfJN6rLSdci1AYOivCDOw/tyLjNoZSUal/WRboGsMhQ6sNhyt7
    chGUr7PxnEpIjuXb7S2WLQ2Sp+AFyYHgw3UAjfoL1J57zSl3NTFMOHD6jEV2Cmcj
    99MgHxKxzoag5h7T8BXtMvkDfLqez6N65qZWp1gk564C8BxZ4wWEt2+YkjC9OSpv
    j6dI8d3WNisNn3lxfMwIovuOluLcKd0ZEWAtjgI6Zln7bB4vjF36bxiZPSU3pY+V
    fZB/1Ex5EfS+cTMjyDdldpZ7tRMrlFwIDCybjm3SUBvy1/V2P1xBV+4axWBNmzw7
    ntCSnDbJQud9dUzB6TXsd34aOYEJgM1cbWrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523239715; bh=XSd65KZaPU
    1jKjGwj2Jva5Y+pJo9GaobbXogIO3P3tA=; b=ZdkmZ924L4jHvBRIONQPgiEvGE
    QLO9lhvl33kxpknr5orFga5HE79+YFbLUrIPM3Mnvl7hKNCzLEKXPF90gS86Yxjo
    j9wuA5+E6gaHR9gtyi/17LwPN8fvFR/rbwZGazxNgx+Exhg4r3VBW9ZbCWse0q/R
    RDUtm0aGyUJSwtAuO6iOF0lgeS6ZyVCUV6jiQjqa3y31RO03iXhA65xK4/OMWoHI
    p1RzzJ41p2AN7DwzyY0OnwY+o/DpOhhMn5Zg98lYfRzj6jAO81yDy98OWO/8UiQL
    u+W+V4tnnvAEXbrFp1CdDwNRmoJE7JnXkQyrivp9vknRrPTgCnXpfPn8pu3Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GrcarUuZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GrcarUuZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfATiM5YaX+QrJRWTMD5l4wWvly6ZdxIYjluc2PKly59VrsFhVaDgnxlGycFvgGvE0nye3lJ83T+BMhiipzEK9CO/kK3SGw5/vCFqUqzl9N3RzHDDFFBk
    KshWW9YFiagnqZsmqKrT6anwWrMGMo3Ko3kmiZXA5bi8cfhoPeXh65A24NHpwV/4B9C/dT6cgByYGrSGxFbeiF3FEf+FSXRPqR1YQjMApzVdD8/B7SZNLxW9
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=gtszlLNY2Ok9sFHHsswA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756824AbeDICHD (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:07:03 -0400
Received: from mail-cys01nam02on0107.outbound.protection.outlook.com ([104.47.37.107]:40886
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756273AbeDIAbZ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:31:25 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Johannes Berg <johannes.berg@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 176/293] iwlwifi: mvm: unconditionally stop
 device after init
Thread-Topic: [PATCH AUTOSEL for 4.9 176/293] iwlwifi: mvm: unconditionally
 stop device after init
Thread-Index: AQHTz5k5yQAPQM1hC0qk7cl5xB3ilg==
Date: Mon, 9 Apr 2018 00:25:12 +0000
Message-ID: <20180409002239.163177-176-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1126;7:RajSuIsMnmi3JkU0HaU4eChQFGBeb76tah2A6U2JpOjqHXIJyMtku0n/3Nuvjbnal64nwAFdFpCgd6dzYBjQ/q3VYOV+ITRZNWkG55BQp2z+5BkfJZSqHxfgqA45tLlRHxzL8bkKYhzYaPGLejJj/gxWalOGL4Y3rUN2sB/AgCHwXb4Smh2vsEspnlZUfRxzyq6RKHYQdYEIEl17RB1cGScD81F8Lv6oX+x5f6ENefvkYM173jeYL/hP8HoSKR60;20:EdpSKGd2UaC6sGvhb+l1RpO9YBIbytJqgTjYqyn8RQ91drOL+NN2YT3KCzMyq33XfwkmvN6dT9nn/edxcTiD37BF3vuB9Hpe/zoH/JXneJfxyQBDTKbDyp4i0w/l7Z/hEnjTYS1l7rw8O8tvwYFtagE2pIed7Rle7bTz8yZgxS8=
X-MS-Office365-Filtering-Correlation-Id: 9b003d65-3b92-44f4-2345-08d59db1381f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1126;
x-ms-traffictypediagnostic: DM5PR2101MB1126:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11269B96298B27421D0BEC95FBBF0@DM5PR2101MB1126.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1126;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1126;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(39860400002)(346002)(376002)(189003)(199004)(2616005)(476003)(81156014)(8676002)(81166006)(3846002)(486006)(2900100001)(6436002)(186003)(478600001)(72206003)(110136005)(54906003)(2906002)(86612001)(6666003)(2501003)(26005)(10090500001)(102836004)(6512007)(6116002)(14454004)(5250100002)(10290500003)(1076002)(575784001)(446003)(3280700002)(3660700001)(11346002)(8936002)(25786009)(59450400001)(6506007)(106356001)(4326008)(107886003)(36756003)(105586002)(53936002)(86362001)(66066001)(6486002)(99286004)(5660300001)(316002)(22452003)(305945005)(76176011)(97736004)(68736007)(7736002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1126;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: sBLj9uFlw7LhZCRrX0mlHRyePuStaz2vwcRrh6b9bzWRbZ19U+hPemZgAsVDPurqa2w/PotrghqoGzt7NX2pxCJZdHUanmZ3Hp/9L3HUV437eKoZ4nMxVqbFiyztchenvhMVrDyL3YKaxM8AR7NKNKTVaDUzPkvOhZR3RqaHjJF1W3j+ToY9RlqfaMc/+sI02W+mWnHFjugmPWWxlGK754rHm3ECe5yZwgWCP2ypxBIQACbYzziDsecAvsAvUC7LX5YdpFlcu38mUyrTjIvWe22BkpoC4CwKKnGI3hjImWnRFVl6tAFCxIWwvKqoXMYRiIYfsvCQ268CbK4BG68hAIY81k8dfAxhsXctc6GZhsi9BDpuYu7Sl6JHj9YwSGnwZxYvdepnB6P0WQzpPKL/tQ5IndWlPoFR8jWSIHkFidc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b003d65-3b92-44f4-2345-08d59db1381f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:12.6439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1126
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit b092c9f25d45972cf401ad8bcfee2429bf189e2b ]

In commit b93b1fe3b532 ("iwlwifi: mvm: fix init_dbg flow to work
as expected"), the code was changed to make the stop conditional
on not having failed (and on not having init_dbg), which doesn't
make sense - we should stop the device regardless of failures.

Failure to do so is leading to the device being enabled when it
shouldn't be, and - if it gets re-enabled later - the new context
info code gets confused as paging data wasn't freed.

Remove the invalid error condition again.

Fixes: b93b1fe3b532 ("iwlwifi: mvm: fix init_dbg flow to work as expected")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wir=
eless/intel/iwlwifi/mvm/ops.c
index 5d0b9bf8996c..f03d42ea9a90 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -718,7 +718,7 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const st=
ruct iwl_cfg *cfg,
 	mutex_lock(&mvm->mutex);
 	iwl_mvm_ref(mvm, IWL_MVM_REF_INIT_UCODE);
 	err =3D iwl_run_init_mvm_ucode(mvm, true);
-	if (!err || !iwlmvm_mod_params.init_dbg)
+	if (!iwlmvm_mod_params.init_dbg)
 		iwl_mvm_stop_device(mvm);
 	iwl_mvm_unref(mvm, IWL_MVM_REF_INIT_UCODE);
 	mutex_unlock(&mvm->mutex);
--=20
2.15.1
