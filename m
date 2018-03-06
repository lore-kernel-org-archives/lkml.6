Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3088149-1520299783-2-14156164574339931780
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520299782; b=DNp+7rwcyeuqEm6oFmd7gW1ueZ9yl1vU3Gl66lGsCJA7GzP
    soup3+K7CaMBoZZmekDLxwwMLXYDtkB3jzFspFiWNFXwjNmv8+ZdQPH/0y20tXr0
    erS3F/K9hwEnpRQfEMnyHI8Z+RWUE0ofI0GC7aowXS65tiWZGsVeY4l0OwlFBlV0
    ivbOPQCRhqBAVbUhax8gZhX1iegqSU/OLGdKsoULWNvu6k1P03HqhIqaPG8jTffr
    y0dJCEP/h+Ui3oQdJrhDXLDFV+Bh+uSdBmXCtckvjV/yNBq3ZAfRJQS10T5ljjLw
    iEwBfcJV54yNrpdqp9Oh6Ox/80mI12JYHsCeh9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520299782; bh=XuPOIF5jSU8A09Fy/yYdMZnyhl1IOaYjI5ontwcGbMs=; b=B
    Ywl8uyZ7dzfm0/4HFUsg8JbDZclBreqLj0VxHEeDbalezuGyAw416LWuoRd3HoPn
    g7iyHnguaxMPG3gTUJc/ky0bwQTI14E+UkITh0XBsOs2tF8hgVaSrrDMOY+EQRKc
    EckFUcrGiXovhLjh7PNS4n8Q9Yt2pB8+iUB8mTQeA7PYDMrO3G/RKGGUGfJ2noXX
    ATwmVUYIJ21dK0N+SVc+n2JM0ALR2u+eUKlZ97svIKEMdc9EKdiMXtjpgxd9H0+5
    +DroBGoV5wx1JoYkjY72Li0A0wlWCICGZ8RHbFSqWg0PL3t3scADYOH1BhxfIyNU
    nb+flTpgqa97hRoVNUTUg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=IU7YtVAh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=HReTB9Or x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=IU7YtVAh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=HReTB9Or x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752908AbeCFB30 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 20:29:26 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51078 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752543AbeCFB3Y (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 5 Mar 2018 20:29:24 -0500
Subject: Re: [PATCH bpf-next 3/5] bpf: introduce BPF_RAW_TRACEPOINT
To: Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, <davem@davemloft.net>
References: <20180301041957.399230-1-ast@kernel.org>
 <20180301041957.399230-4-ast@kernel.org>
 <56cd9ef9-41b0-dc89-fa49-92a459796515@iogearbox.net>
CC: <torvalds@linux-foundation.org>, <peterz@infradead.org>,
        <mingo@kernel.org>, <rostedt@goodmis.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-api@vger.kernel.org>
From: Alexei Starovoitov <ast@fb.com>
Message-ID: <dbac65a5-0e3c-7098-b9cb-1f2f5b9aee9f@fb.com>
Date: Mon, 5 Mar 2018 17:28:28 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <56cd9ef9-41b0-dc89-fa49-92a459796515@iogearbox.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:180::1:2cf2]
X-ClientProxiedBy: CY4PR18CA0030.namprd18.prod.outlook.com
 (2603:10b6:903:9a::16) To BYAPR15MB2501.namprd15.prod.outlook.com
 (2603:10b6:a02:88::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e2a6280-c091-4983-1b90-08d583019481
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2501;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2501;3:7wmqtFlMoZconaqjZcq8jPKCybMe6kIerKmq2l+YvqyvORD1KkxiyzhtuLfhDlCiX5csgSz0mFvanYpjph7Y+I24HXu7FtfcYFVF23F6PHmikpSgczM7qpxOmW85uhFN9gohlNyOHXkFiAItI3NEHwGXS0MPwVnylgaoKC9uUBSSsPyrzY3PEq2wYsg4lGm3ENQCy+4olKm9JQjAfwRuhVhXZQ+Fk5TSptEUSFQTxOGZlGI05jcTE6bw25zgkwgK;25:CAfAmrHwOwvakxVZbza+nqGUrPjvEXwR2tBKEvJAI/nuYHu5zay4HeK3OofPRYj+3iEFOrgL224+HmE5VkQ3+JlK+zgnrL3xSf9ctqulOsI/HS+Yu0J0YRLMKMbuHLLTTB2cCVE7ISF3SaGvDoHnbXQVSTdO7CyHxVuEkaXX5Kgzyji4w1J2DlvJIpAFf/+wj4Yzb0eYZrl36F4+THDBUMnvsgimR+iCiesXiIhD31lzwA+qU41FT6lIcNU6ibf7kncrUam7tthSBYuBs6KCercCyehXogFZXjVxmI+kpQJg8MDgijLavI6beqv7a5FsX2cH0qN+cFbQLEf4b6gnzw==;31:0/30Dkw3OPQWDTTMo0Md8Rc0lPNXL53MXQ9tjKxk0iptW9Q71GHrYqrQkkbtriBFYzF4eKw9TGrfrVme8QBcu58Qd5fvkJc20KjqM2g8Wl1NkpFmmMnuN4hK9IQHJLWaxUtpBDVHTSQLxqHHPF+a1z8mld8wxcMHGMw2JiEW4SCitl5jWPmkw/cJHUsiG7QW8aKLvmrBNnUSiyKtWMjgZGe4kgx9zZQsdQtghHYrEQo=
X-MS-TrafficTypeDiagnostic: BYAPR15MB2501:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2501;20:dJ2n2nYjeW7sOOleQiud7pTiHUf9FLcUBkXPss/pYFY7U1xadqIzNKN6O2vvEUTcLBEB3JEhM49qr3DTJU35VtOPVzITr50EOQchYDftQpER9op7rDLTr46pEZXBKPfTS5+tBD3zJuNiG+7mH3cqxeRq+16tdgPohdUBkOVZF+EayrPJDSxOvpObDdNP8tqAOPb2QlbB0xk5IFECXokOUvygJBKC8m3NwZ//JUXEd9iW8Mdf8Ogen9+oAWSAfm7zh42KZIpKdmyeMM45uUqOMynWh7Sq4QIVtZnc/63+j9LQW5t0ljs3JgD/JaGVi1wn53Jfm2O/yQnIFVOnAv3213w6Q9tXKDHHaDDrJNyj2IkGq7rn2R0+M2HFPEzVJTM8L6c9yi2WQkRPAkrtUG/QMlUt6uy2aFQtp1Jh0xIwaIA0RFW8qA5k0w/OhhgpEKistbtzPZ3zBFG4gxu0na+B6TfNs8EEMOzeRBbZcGvhrhEqQvRkBAQYW775bn5DABXR;4:5Z7l+FVwRPhC5/4hNkv0sWfL0m/jWYIyvuf9XxeZI4oy6Rq80SkzW4++GpAYh8YAiI6ajEoeosXTfYyo4+FRXiRRYg2bu2BLD8MciYgL/NznpUXvEumACfj6PMg8bPYNeFZD55wnKx3zZLXO5nISO2NAAAqtlLMYv8Ek9c7sq5PlBylS5zf/VAjvMiB5vsilMpXSYNh+yZG1c2AsfIb5owrtzQFvMCwRQeDZAGF/6lcZAJM9eA0QMMrIQISFT5WI0PMZtYCpihuoqSkicQzpR/L+tWRjNWtsdugPYKjjN0rYlViwrFuMOwN804n61M2h
X-Microsoft-Antispam-PRVS: <BYAPR15MB2501A4A650C28B96BF45ED2AD7D90@BYAPR15MB2501.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(21532816269658);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231220)(11241501184)(944501244)(52105095)(3002001)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:BYAPR15MB2501;BCL:0;PCL:0;RULEID:;SRVR:BYAPR15MB2501;
X-Forefront-PRVS: 06036BD506
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(366004)(39380400002)(39860400002)(189003)(199004)(76176011)(52146003)(65806001)(2950100002)(25786009)(47776003)(6116002)(8676002)(31686004)(31696002)(6246003)(53936002)(97736004)(23676004)(1706002)(67846002)(6666003)(52396003)(86362001)(4326008)(2486003)(52116002)(65956001)(65826007)(105586002)(478600001)(58126008)(316002)(386003)(305945005)(68736007)(81166006)(106356001)(5890100001)(7736002)(7416002)(110136005)(230700001)(64126003)(53546011)(81156014)(36756003)(345774005)(59450400001)(46003)(2906002)(229853002)(6486002)(50466002)(5660300001)(16526019)(8936002)(186003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2501;H:[IPv6:2620:10d:c081:1132::1018];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjE1TUIyNTAxOzIzOnN6dERLWXRjSWRnSC9RczhEWFliNmdUQnMx?=
 =?utf-8?B?NjdPb3EvaVFtYWhmSkczOFZWTzEzdmZ1UUhlQnlaQ0hhSTBhSGFkWWJDczFm?=
 =?utf-8?B?TDFpTWlVUXdKWjJHTXVGcWY4VkhKaTA3N0s4cWVOeFRXRFNxUmNUYjFSYllD?=
 =?utf-8?B?cE92ODBDUlZYalNWR253Z3FDanc4dDg5VkJIS2NYQnVsMkpKVVgwalpLYUtH?=
 =?utf-8?B?bnZCbjl0VTJ6ODd1VFBaVm5RTzNRM2YxZTVSdm50WXh4Y2dZMnNvdUVmZkZI?=
 =?utf-8?B?djJIWXd3eW1tZThleUhzNWhOa0xITGRWdHZHbGp6L2JvaDJob0NrSFh5bFB6?=
 =?utf-8?B?ajBsMHFjajlWdlB1NmZwZHZsRnpENWpPMmd0N2hUZjRSaVQ1cThlMC9YcWd3?=
 =?utf-8?B?TUJRWm5USGwwVmhnbmFEcnJ4L0RJaWh2SW50M3MvMDVVZ0NnMTdvN0FERTFn?=
 =?utf-8?B?QjFZNXdxSmlkaXQxSVRMR2xxSVdnOVdBaFo2VGtGNFdXajRoM1JNNmhEeXNi?=
 =?utf-8?B?eENjQlE5cmxIVDZ1VzkyQVBCS3NqZXo4cHFGck0wWnpwVzRsV2NaQ1BWQ3ds?=
 =?utf-8?B?V2wzb0lmN0NGVHNITjdvSExvcUgrdUNpUEh0L0dENitYcWhOdXJJUW1zTlhz?=
 =?utf-8?B?YU1TajdnWWVkRG9jZnd5bENwVEJzVkg3ZHJIeTQzZjdzWlJ1WDNkNVJEckRT?=
 =?utf-8?B?UmRsWmJWSEtyMzZ4VnlLVVZnd0JsWGhYR0lEVDkveXA1NytBNTB3dUhjYzJZ?=
 =?utf-8?B?bmF1MEpXVHgvQk1vclRMMy93QTR2Z040bU4xdWh2a1JBVUtjOFdQYktmNEQx?=
 =?utf-8?B?anNsNWVpQTNTWWF1aE1PcEcvN0RFSWJJc1ViQTd2TGZrcjE5MlUyWVdmcThw?=
 =?utf-8?B?b1lCbjIxT25RUzlVaTJJbVFJSk1mR0RHRG9NMlZ0Wk1Jdk5ISmh3a01qN01Z?=
 =?utf-8?B?SmZqTjNTdldacXozbHV5cGJBT0c5emZWVjd3Y3NUL045SjdiUzFHY090ZXJq?=
 =?utf-8?B?dXBZN1g1RUhhd2NXc0d5Yk96RWpsTVAyNHlLZlVNNXlEcmFLQUd5SVBvV3Ey?=
 =?utf-8?B?L3JsZ3VXVlhCcVhsM3JnYnZXTVdsVlRFcnA2ZGlBWFNmeDMyYnJCZXRsUnVu?=
 =?utf-8?B?RDVGWjJRNkhXQXlDRFg5aDJCSGt3dGp4NzFzN0dIbzhUWW9HYlRQaEl4NnRh?=
 =?utf-8?B?bGxyV1FtNG9OR1dadzY5dklDY0o4V1hsdFpSakJiWEJSTFdzeEFablFWR0ZO?=
 =?utf-8?B?cmQraFJqNFdEU1dlVVZzU1ZwT1k5UEdDWThxcFNlY1pYcnZHRHlmbXMrZnFT?=
 =?utf-8?B?S2lFMk9PSmRjUC8xUzlJVkdObkIrZkRlTXJTSGJJcG5ZNDA2SlI2RTdaM1Ri?=
 =?utf-8?B?djNKdmh2bnlDSkg3bTJrSGVaUStuaG5tQ1MxK0p5NnJNZFhiVFVuRGkxQmdV?=
 =?utf-8?B?T2dwN3VraThSV2t3Z0xWa2hZbVdUQjhsQ1pRV3dOLzBrUjk3TnZLTmVpRDNS?=
 =?utf-8?B?b3FheUplbnpkcjNTVkt2MEZtTnlxQWhFeWp6RDZ6Tmhvck1lK3Z2QjdINW95?=
 =?utf-8?B?cGVvTTlKYWN2SEtMZHVZL1MvMENOTFMxcnhGQllxUkpCRjcvOHRLdTdjTjIv?=
 =?utf-8?B?TWxuelRObTBtZFNKVCtla0tqVlRCOTVTZUFFRHVCemdMOWU3VXBjYTRaWEM1?=
 =?utf-8?B?emVuU1hHMXhDUGlDeEtBRFZRT1lkTnI5YUN1RUhPOUNLWS9PQVR4TUg0NWx4?=
 =?utf-8?B?cktZb1B2cmswOGltRm0xK092Z1pVR2J1Y2pDVUxVOVk4TVMzVGVKSzhCTW1V?=
 =?utf-8?B?NDlMdjRrZHB2U28xVFZpOGRHWS9BYVp2Q3FkODBKeGttalBBeVpLTkNISnlV?=
 =?utf-8?B?VURWbWU0NS9ZdWZCRDFQZUwxSUlORUNIL0I5YTdzdUFaOHowZmxIa3FTUm9F?=
 =?utf-8?B?dUxCRk4xU2NRPT0=?=
X-Microsoft-Antispam-Message-Info: nL0wBszuA410/Xle8pOg2iJaIJxw2m1Yn+NzJKJ1nZlQgdux2NjSTzePciRYRa5Bt/1kVZcWNDZFSAwg218TntQ51NKMFCfCfZIkhuONsVFbyzZFfa3rX/V5NAt736VAaTp455LnfN8pTb+xaxYXpcS2A6M++V84kq776y8HXdKO1JmRg4EdLsPhfhQfSkwL
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2501;6:cLk0+QDfIOaF/1YQZPXPn3OnW/+oOgF17R/WkD+Exm49t4cxW72dqf0rkQXurrIH2TGZUFkL1siPVzC+1HGe/ZgnndegyArN02JNsv03cu8iQGy4vs4zwJ9ICkgBqdyvn+MfjjYT75DoQlvvFQfm0TRHOdW7+DqhAFq0Wwz9+HdTR8XleGH4jHUGgOLXcGi0SPvbxe7Qa2w1PnTo8RWyOQcYksn537a/ZXBHj47zPv6ywL9atAAWEpGjKZIJLQDJ1fUIIETbHcJlgn53EkWLKNd5uQ3nux5TQWMJBLGR9hAY4riSV2zBu4518Kp1vv/d9wMA3weKvm+ClSObfeadjHYhAZ4W/6Vy/2A2k19lA/g=;5:g77FrWQUuqE7p2mrE+Hq/ukyOyimeb25rh5gqcuR/txmaRZ8Mb6ncRkUgj9TcyNtq0gsbQd1W6Bnq+o/bCanpu8nsgGDfKsUPCiE/nZgy45wsrcYUIRaHkUQScOxXbvt5/6aK7wieKVI4GCaHY4fn153rQrn8rlSUmTtp5uKtPs=;24:iYtJ4iRI0vKOcmWo52mQRXAyfdBwELq5ZlU9aQTrLbyHoyHilUDLQ8baeIdsrPG6/iF43mnRNEW+Du1I10EJdoGAv+2i0BTX9K5u9+2Iar0=;7:Ihfu1ZEHmc4yUqdIyXgdnC7XTaea8uAEEqliDd/BBKcBLCGLizC4QDlpWcoIzB+PGPM/owyfYkGgvgeSfJc7HjyRwYoUXkKJ78pn4VRh6fec17PpNKfSP4pDx4VPeWxLp03TrGag5GIxp3SsJQEW2s03ysxDxfc46NlBvSm8RLL665P8r+MqYdP936ZXwEnM7IgDa+s7Jh/FbnANyNEkVUw17O+ftuqP7+37rE/RbYnEmsKD1KsDDEqBpeAXLDtP
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2501;20:aizSLywc1PvVkmO0R4gRtJyiSvVheLnACjyvJwfyid76zlmtj8ERT5dHKPpQu/AXnuFI6wJozuGWYTvoVJqwIerFn3EJlnsaGKJtViUYPK1EJx7dZWJ7nztJDX3Rx1WaNocbKiOlBHVkT85eYGJIWHZYIbhfNWpZP9AyIlIfkmw=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2018 01:28:33.6081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e2a6280-c091-4983-1b90-08d583019481
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2501
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-05_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/5/18 3:56 PM, Daniel Borkmann wrote:
> On 03/01/2018 05:19 AM, Alexei Starovoitov wrote:
>> Introduce BPF_PROG_TYPE_RAW_TRACEPOINT bpf program type to access
>> kernel internal arguments of the tracepoints in their raw form.
>>
>> From bpf program point of view the access to the arguments look like:
>> struct bpf_raw_tracepoint_args {
>>        __u64 args[0];
>> };
>>
>> int bpf_prog(struct bpf_raw_tracepoint_args *ctx)
>> {
>>   // program can read args[N] where N depends on tracepoint
>>   // and statically verified at program load+attach time
>> }
>>
>> kprobe+bpf infrastructure allows programs access function arguments.
>> This feature allows programs access raw tracepoint arguments.
>>
>> Similar to proposed 'dynamic ftrace events' there are no abi guarantees
>> to what the tracepoints arguments are and what their meaning is.
>> The program needs to type cast args properly and use bpf_probe_read()
>> helper to access struct fields when argument is a pointer.
>>
>> For every tracepoint __bpf_trace_##call function is prepared.
>> In assembler it looks like:
>> (gdb) disassemble __bpf_trace_xdp_exception
>> Dump of assembler code for function __bpf_trace_xdp_exception:
>>    0xffffffff81132080 <+0>:     mov    %ecx,%ecx
>>    0xffffffff81132082 <+2>:     jmpq   0xffffffff811231f0 <bpf_trace_run3>
>>
>> where
>>
>> TRACE_EVENT(xdp_exception,
>>         TP_PROTO(const struct net_device *dev,
>>                  const struct bpf_prog *xdp, u32 act),
>>
>> The above assembler snippet is casting 32-bit 'act' field into 'u64'
>> to pass into bpf_trace_run3(), while 'dev' and 'xdp' args are passed as-is.
>> All of ~500 of __bpf_trace_*() functions are only 5-10 byte long
>> and in total this approach adds 7k bytes to .text and 8k bytes
>> to .rodata since the probe funcs need to appear in kallsyms.
>> The alternative of having __bpf_trace_##call being global in kallsyms
>> could have been to keep them static and add another pointer to these
>> static functions to 'struct trace_event_class' and 'struct trace_event_call',
>> but keeping them global simplifies implementation and keeps it indepedent
>> from the tracing side.
>>
>> Also such approach gives the lowest possible overhead
>> while calling trace_xdp_exception() from kernel C code and
>> transitioning into bpf land.
>
> Awesome work! Just a few comments below.
>
>> Since tracepoint+bpf are used at speeds of 1M+ events per second
>> this is very valuable optimization.
>>
>> Since ftrace and perf side are not involved the new
>> BPF_RAW_TRACEPOINT_OPEN sys_bpf command is introduced
>> that returns anon_inode FD of 'bpf-raw-tracepoint' object.
>>
>> The user space looks like:
>> // load bpf prog with BPF_PROG_TYPE_RAW_TRACEPOINT type
>> prog_fd = bpf_prog_load(...);
>> // receive anon_inode fd for given bpf_raw_tracepoint
>> raw_tp_fd = bpf_raw_tracepoint_open("xdp_exception");
>> // attach bpf program to given tracepoint
>> bpf_prog_attach(prog_fd, raw_tp_fd, BPF_RAW_TRACEPOINT);
>>
>> Ctrl-C of tracing daemon or cmdline tool that uses this feature
>> will automatically detach bpf program, unload it and
>> unregister tracepoint probe.
>>
>> On the kernel side for_each_kernel_tracepoint() is used
>> to find a tracepoint with "xdp_exception" name
>> (that would be __tracepoint_xdp_exception record)
>>
>> Then kallsyms_lookup_name() is used to find the addr
>> of __bpf_trace_xdp_exception() probe function.
>>
>> And finally tracepoint_probe_register() is used to connect probe
>> with tracepoint.
>>
>> Addition of bpf_raw_tracepoint doesn't interfere with ftrace and perf
>> tracepoint mechanisms. perf_event_open() can be used in parallel
>> on the same tracepoint.
>> Also multiple bpf_raw_tracepoint_open("foo") are permitted.
>> Each raw_tp_fd allows to attach one bpf program, so multiple
>> user space processes can open their own raw_tp_fd with their own
>> bpf program. The kernel will execute all tracepoint probes
>> and all attached bpf programs.
>>
>> In the future bpf_raw_tracepoints can be extended with
>> query/introspection logic.
>>
>> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
...
>> +static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
>> +{
>> +	struct bpf_raw_tracepoint *raw_tp;
>> +	struct tracepoint *tp;
>> +	char tp_name[128];
>> +
>> +	if (strncpy_from_user(tp_name, u64_to_user_ptr(attr->raw_tracepoint.name),
>> +			      sizeof(tp_name) - 1) < 0)
>> +		return -EFAULT;
>> +	tp_name[sizeof(tp_name) - 1] = 0;
>> +
>> +	tp = for_each_kernel_tracepoint(__find_tp, tp_name);
>> +	if (!tp)
>> +		return -ENOENT;
>> +
>> +	raw_tp = kmalloc(sizeof(*raw_tp), GFP_USER | __GFP_ZERO);
>> +	if (!raw_tp)
>> +		return -ENOMEM;
>> +	raw_tp->tp = tp;
>> +
>> +	return anon_inode_getfd("bpf-raw-tracepoint", &bpf_raw_tp_fops, raw_tp,
>> +				O_CLOEXEC);
>
> When anon_inode_getfd() fails to get you an fd, then you leak raw_tp here.

good catch. will fix.

>>  		break;
>> +	case BPF_RAW_TRACEPOINT_OPEN:
>> +		err = bpf_raw_tracepoint_open(&attr);
>
> With regards to above attach_raw_tp() comment, why not having single
> BPF_RAW_TRACEPOINT_OPEN command already passing BPF fd along with the
> tp name? Is there a concrete reason/use-case why it's split that way?

The use case is to attach the same bpf prog to multiple raw_tp,
but with your suggestion it will work as well,
so yeah will change to that since it simplifies uapi and avoids
the race in attach.

Thank you for review.

