Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2440679-1521584967-2-12682169517104888923
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521584967; b=noYzf9MKdLQqzh4qB1cETOpgYB/CP6pWyOfH615UqoeWwt0
    /yeHyG78IrRjn7Kw3vczBgZoGHZFFsW0zVxSctPCdMve2CQHlBp8B7n+zJl/nXOX
    ltXa8PGdZg4okcbPtjnOPE6OlrEZUtJLkMbfwHOvXq9vgsD0n8JVj3UVYETmr2gG
    94MMlHGbJz6pV1jmrDUH1YYyoUGV9Xj23RP1rdb8XUv/EkPeYCFGfy5JkHkw185Y
    h/cpe9tZ4j49ZYX/KRZw5WPDPc4rt37/MZiCQbJgUv4O1iQm2j994nDaao0Wknij
    J+w1ELoXEx0PxXpFAj7WnUNenYCy476ToDOET/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1521584967; bh=+GOvMBGNXWdVWKh1hKA/YUNiREdiDK+9Xqinjd
    SlfTM=; b=eDljBjmYPYOYM7THAJ7OLxyUrJsBmY3HWfEktZj8hekMVY6MsMvzX+
    BBG3pfoxzPERnrhqhYXbRaG00YkSkqLwGeSsPvYrkwjmR9e29OG3h4f0pZgYSdd/
    Yopmf8SfDJK6zGxgmDW3+G92cMyxUWASorU5MD5oJmMzXEmwdnTXxIeJFO2YXwID
    xoo2wYmJfpyBeoPkcd0LRWrWr+HjMFWt9parVmRKkNxqd756DnRJWrSy+oe1xF2y
    alrGFiMgR7cEYKCvDLiLkjOyVCJSQSuENUte6UxEjD7ZtDqAVn1yxnXo5FIKvf7Q
    83IqvnB1soTjRM+W6uotcce7gZKMj3LQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=EARvsjBO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=pass (1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=Xi0V7uBj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=EARvsjBO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=pass (1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=Xi0V7uBj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751372AbeCTW3Z (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Mar 2018 18:29:25 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57426 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751334AbeCTW3X (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Mar 2018 18:29:23 -0400
From: Sahil Rihan <srihan@fb.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: allow TCPA log area to be empty
Thread-Topic: [PATCH] tpm: allow TCPA log area to be empty
Thread-Index: AQHTuItC/RRm9Hus7E2B3o7PByJEg6PMtTQAgAYlz4CABAOdgIABQaUAgAEvBAA=
Date: Tue, 20 Mar 2018 22:29:09 +0000
Message-ID: <A799BB0A-C44B-41AB-9C38-4B974A50210D@fb.com>
References: <20180310161637.7723-1-jarkko.sakkinen@linux.intel.com>
 <20180312150231.GA24717@ziepe.ca> <20180316125525.GB5035@linux.intel.com>
 <20180319021323.GD27186@ziepe.ca> <20180319212436.GD14364@linux.intel.com>
In-Reply-To: <20180319212436.GD14364@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::5:e963]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1486;7:WVUgBjKH9ODPHpXqpoWajT5bEIGnf4/GW2/rjCCmg+AUztLv/R88zLdTcHVQ7TBSlRU82TEd/P85/2nbzTnm79ZqrTj94k7M4loVsSg7usYZhynzvAhTHDeDqfUiE1j1qBW2iGnyGS6moQXuVVfWZRALyAakRlTJ2UOhvmfvqZJm4YyK+9UBm9MZgIK0Iy+EghvJRHRp0CtYkhdvAcNIVJxVcGKN5Non8oGtjNK3cTT0crXdHiQcHvKuhFimfHov;20:Ujsf+2+KQWIqmPHmH4Dsbl5JeEDh2kUa/XWjjX1oLHLsCAn+WjvP8re4EVtSKnjqVMx4HGaUBSjp0PYyyLU/gufWXtu4A5mEOBvzJxA7oKhusqHHoNkrM5row4V5AfSWJdz98L5TJ4D2D/ZtPWDepoVdftD1R4lKPTcRGM/J2wo=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(346002)(376002)(39380400002)(396003)(39860400002)(366004)(199004)(189003)(305945005)(6486002)(229853002)(5660300001)(36756003)(6116002)(97736004)(110136005)(54906003)(2900100001)(82746002)(2950100002)(14454004)(5250100002)(76176011)(46003)(25786009)(83716003)(186003)(106356001)(6246003)(102836004)(6506007)(316002)(86362001)(53546011)(8936002)(6512007)(2906002)(81166006)(93886005)(81156014)(478600001)(7736002)(8676002)(105586002)(8666007)(68736007)(6436002)(33656002)(3660700001)(558084003)(3280700002)(4326008)(53936002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1486;H:MWHPR15MB1149.namprd15.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-ms-office365-filtering-correlation-id: 33949251-7237-4908-4b5e-08d58eb20019
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1486;
x-ms-traffictypediagnostic: MWHPR15MB1486:
x-microsoft-antispam-prvs: <MWHPR15MB1486D376E0332FD4D0E4D01CBEAB0@MWHPR15MB1486.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231221)(11241501184)(944501316)(52105095)(93006095)(93001095)(10201501046)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR15MB1486;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1486;
x-forefront-prvs: 061725F016
x-microsoft-antispam-message-info: Dv8hdg7O7NQCHKhgZ5rmewslznQcEE0kFuihfKmJM4uNuZkPT8w4SEO0KtLdm7dhSNqaCq3yTGD7rjDItK6HsYXshXwt+4HKKsCkoTnDC4IY9CroDuWM5hoPWyzgBHRBo727VCJtysutb1eAXKT4PYv9JHndiq6P2RmWp2FhDX0qtJMG1uwbUf03FEyvSkpL3yRlBFo/SQkVVyjS8c+zNfThAwN4DrRYllwRkIUr3t31BSxZgM8/Y49m4Q9BNymQ2bRkuKXU1+c2JwnYaXwvEV/Om+QR1s7EHnVBE66Vyiax7ScoUa1tMA0wYK/qXunmvunMKNTRw0X7J1Pye+iFWQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0581FE107E2FA46AAB428EEE652F09B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 33949251-7237-4908-4b5e-08d58eb20019
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2018 22:29:09.8367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1486
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-20_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

PiBPbiAzLzE5LzE4LCAyOjI1IFBNLCAiSmFya2tvIFNha2tpbmVuIiA8amFya2tvLnNha2tpbmVu
QGxpbnV4LmludGVsLmNvbT4gd3JvdGU6DQo+ICAgICANCj4gICAgU2FoaWwsIHdvdWxkIHlvdSBj
YXJlIHRvIHRyeSBpZiB0aGlzIGZpeGVzIHRoZSBpc3N1ZSB0aGF0IHlvdSBhcmUNCj4gICAgaGF2
aW5nIG9yIG5vdD8NCg0KWWVzLCB3ZSBjYW4gdGVzdCB0aGlzIG91dC4gTWlnaHQgdGFrZSBhIGRh
eSBvciB0d28uDQoNClNhaGlsDQoNCiANCg0K
