Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1163969-1520621554-2-2091980791584432148
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='windows-1252'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520621553; b=u8/PODpFGhQBqZDYyZ7ZiJql9wNRq62Jn/iAb2W2NiCXSJL
    3jPv5pBY3zBJtiyLsub5qhdMAF9ZWaM114wEj/4+hDNYqxv1ymDMYLcFUCg9eVBJ
    HHcNrLrGoCINSOjZjd8nf95QoyHgAbdSOW2gpTgxH9tV2kS+RV+vV3XLN2Znf4c7
    45LIKsXT0QnljHrE9oFqv83bc67xDFjmJclWJKUU2j3wdRh6ZjuqSZpmZ9LvOU2a
    1H1KP8iZJj/oOsR2K6lAFtlazEHdxCTlxqbVw9KjT4H6v+CRCG1F7+DR0osbmaD3
    QTi4oP18k4c4e7tunfBef46QJv++kHB13aif3mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520621553; bh=3WRGCoRn1NmFsqguHW6/A8rWqkdlzdgDOgQP0r3MMmg=; b=t
    hd01wfeLC/T2TeNJfNijxbokrjDbrWpEEcjD0rhMzHFcgclx7I6SKob96lvPo4wL
    yW4o6BXa9GzQszakuZDGGua4zWUt+smUiISYytyjqxhOP9Yt6ibWiY4293qEsRQw
    vRG+cSn8GYAsI4KA5NLFxt0tFRSdz5Je2+7zmsSXwifjv76xDho3rCsL82pbslb0
    jVvAZEwC9U9IemwbXsdwu8ZGXrRiTI0JWob/BrWecfiSGsZ4IrIGsi6EAPOEjRea
    uwWGwT0bfWYOlY+GpPB75pQL+u5FyjEcpMf0BJsAS2lAvm31ftTOYdJJoDMhFuOH
    Qf2sDwLaF9KwjVH2uk0aA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=dJfvpgog x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=TwJWlwvh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=dJfvpgog x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=TwJWlwvh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932542AbeCISwM (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 13:52:12 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37802 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932072AbeCISwJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 9 Mar 2018 13:52:09 -0500
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf
 binaries
To: Andy Lutomirski <luto@amacapital.net>,
        Greg KH <gregkh@linuxfoundation.org>
References: <CALCETrX=Vfk1T-XegwnjtUqeEsyUFXH1744d0yGkufQvDA5xkQ@mail.gmail.com>
 <CA+55aFwJPDub+tdShCgeTz3UejeskVE7_x+eQLq75mCjYPyP8w@mail.gmail.com>
 <CAGXu5j+B4wgT3ovynAxa1zwCeROfN5zK45tL1FUnFh0sg8M5AA@mail.gmail.com>
 <CA+55aFwRGDPvaCUgMtqnQHb2PZ77JSMQMQVf1znSN+PiV7NR-Q@mail.gmail.com>
 <C94A45E9-54A0-446D-86D6-82D06E2A35CD@amacapital.net>
 <87478c51-59a7-f6ac-1fb2-f3ca2dcf658b@fb.com>
 <CALCETrWKLB4e8Cw6ZRiDP535=HzoQJczsEMEpytstveO15mAMg@mail.gmail.com>
 <6d2e31fa-d87b-fea6-c919-b7d066bb0385@fb.com>
 <CALCETrX+oGQthnk5AR0MUJwLLwguWG_yq_r9QQPhUYjvz9jyPw@mail.gmail.com>
 <c9388b10-19ac-0bd5-4986-9c306d23046e@fb.com>
 <20180309181527.GA15803@kroah.com>
 <E622B120-3C3A-4A15-8E1B-6F7649038623@amacapital.net>
CC: Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Djalal Harouni <tixxdz@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>,
        Linux API <linux-api@vger.kernel.org>
From: Alexei Starovoitov <ast@fb.com>
Message-ID: <74e26cc0-9e72-f03b-5396-f3480921f234@fb.com>
Date: Fri, 9 Mar 2018 10:50:49 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <E622B120-3C3A-4A15-8E1B-6F7649038623@amacapital.net>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:200::6:ce34]
X-ClientProxiedBy: SN4PR0601CA0008.namprd06.prod.outlook.com
 (2603:10b6:803:2f::18) To BYAPR15MB2503.namprd15.prod.outlook.com
 (2603:10b6:a02:8e::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5cda09c-5285-40c0-91a3-08d585eeb14e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2503;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2503;3:x+Pmgi1nNtSU3bmZLe1YaZFs9tbdQL/e6B7VCzCfmIc7t7R3n/8as9eSLG/TpeEFYhtJrHC6Ezb0gqxhxXFOAkA5XC33Bj28NGnjKcjLPU0nogpcVcZMjhIjUkQgrUDXZQLBEU2tC4SiB/2Ws+wCInl12Uv0FpUlLC3VAQUW/QuTGMX21/7Ip38gdrBOXpmAGJyOLLHXe26T4JesH1XItECxZv2Z+o5f4YpKd+ywakLoa4Qo8Zctkq8mrqRWOAsG;25:r2sywJ3Y6cKzhGu2niX1PHryu1kJLcBx+ugCvPwcXXp7EMXBmYXqjOX6943prtdkzHBwCeqKe4u3KjRvZDuSkNwLILWLiASPZzXOqm7cy/XuiZaLHFulrn0wYVmU4exZ9KYSHK9atFVGf2AKWOYbih0Bv3ABbIPJgQrCljgbWd6+h3IQIH1qeiwNNv4ub7io4mzTEHFraw/D+cTrlBKyznfqufmE8pEtbDTXPeE3mHoQ7BQZ6c9nvQIrq8FT76EHFcajqTqxOhZ4NjPyvCq3yWPnF09Qa3rOQITFjpdPUi7OHkAKctkAWqhvnRrxyOPx2QuJF6i3nsgM1lJTCMFIfw==;31:n1QxmsyF6e7hwJNv8rYEYF6lkXxRU1REXDoJe+8W/FjzK4xKwiQXTvQZHKAG6R2xPh6FtwYgCfxMmnZOo+ZmAjdQI7DV2BchOr3D4Dph3gWcHX5cdybRrrum8+S6w4j4DAHmmKocIjeffb/fYm7nHw6Jn+O4Qh7ShZau1R/2Xgs4RtZjG2n5sk5tc9HjmMO8rgtwUzFIkvlO/2N9ArsGJuoHS2v0252YAKt6tOA70gQ=
X-MS-TrafficTypeDiagnostic: BYAPR15MB2503:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2503;20:3i07z9iVYXaDM32aPjekEUXK8T4T3+2MZuVSUgzoZRwIJ0nUyh6fyqkfsoIBXMaD/lxEfnDqg5NyG9TfNIA3KybqMz3K+GRsT49ejcxC+jlyjJlbSsFKp24f2NusTmo6g0hecBK0c6GxdrH/6Y2fKn656bArHaEP9NvmmfhIyL3AWjnSjd+2V40TiAInQlp59N9oBRnunty7vZ9aDYu+vTUHwW1mUYSfsll+B283PmU5oxd5nSoKXEYQ3p1nQUntt9+RtiykNYTQ7VIr7ghy6D4Jc2J7ubtLGY3bCOf7yypAlQdBw/DvJxxaxxI67Xz+oEQsX6CC0F6rOKbO2a5nUvKCT4YN+SDAvp9Jxexznn98QYSLsjlp0traU9GK3JfcToo/tlk/r3px1G4Mudb/YPmlLfbh3XlMbs1ttwriPFgBJya22q1FLqYWfF//2FzWRpkpYphZvJwXhgcr4SjNg5VOBiIw59MpXr3DSBUcyLweTazPNVnX+kb7+yM0RVTu;4:vMEixa0fiQ1aa87x+64goIse/Y0eR6buKF7us2Lv1xgnE2mRmqSuLNkvzRR6XsYQK1PGGLb4+5eGIBbOmyXZ9ahVlqBCcS/O5XcYqTKkKH4u2PnCzDl4DsxsnphkjUlT7nT9g4WrWm2bKjIFR5dND7UG7C+B/QA3yH+TPlm0fWSxGUiEuSZ0QNkWyWskeYBt+pYqgygj3K5LOxKEnv4aSygdCqNl7VgN2juxf2eJGugpd/SoLsDfwRpR12z44zsXXbUtKu6iLvaj117Fnxgjlg==
X-Microsoft-Antispam-PRVS: <BYAPR15MB25039263505F273FFD1AED86D7DE0@BYAPR15MB2503.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231220)(11241501184)(944501244)(52105095)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:BYAPR15MB2503;BCL:0;PCL:0;RULEID:;SRVR:BYAPR15MB2503;
X-Forefront-PRVS: 0606BBEB39
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(396003)(39860400002)(366004)(346002)(189003)(199004)(105586002)(47776003)(36756003)(58126008)(2906002)(110136005)(31696002)(65826007)(230700001)(5660300001)(65956001)(53936002)(97736004)(93886005)(23746002)(65806001)(316002)(106356001)(31686004)(8676002)(478600001)(67846002)(4326008)(6486002)(64126003)(81166006)(39060400002)(2950100002)(50466002)(52396003)(6666003)(52116002)(54906003)(81156014)(86362001)(229853002)(1706002)(6116002)(561944003)(386003)(6246003)(8936002)(53546011)(25786009)(68736007)(7736002)(46003)(186003)(76176011)(305945005)(7416002)(16526019)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2503;H:[IPv6:2620:10d:c082:1055:7184:6abc:4304:f18];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;BYAPR15MB2503;23:6GAkusfbF9pOaR52TGj7P0Sb6eqnLIrgZHv9L?=
 =?Windows-1252?Q?5swErRJOokM4YEyjsXkRDU8ho0z+Evq4hbTWwlH4yxPjqNjyWdbree9T?=
 =?Windows-1252?Q?XywLgJeXW7jEw/T1COZqi3IjdotaCS5Ok+1OsTuuhNQykW32XLAXE/cm?=
 =?Windows-1252?Q?geSNcdxTVqDD3mElDrPAkVkeKWWhvf6EV/PNPKqPlthclGUTCbsUYpGm?=
 =?Windows-1252?Q?j2fhrTJe6vmAeQGBz2sCdUwlhj6HrAtkUz0VS4y4AdAaAVroiklSiT75?=
 =?Windows-1252?Q?KZc0PENvFOKeEORlMaxSIfnBBloZ3ivtb5FXK6z8nWmE5hOuJQfeoNMG?=
 =?Windows-1252?Q?cOie1/3p25g6mq6wlAslwwhd7uKXXbjMLhLHvKQpK9bcvQ2uT/RvS0E6?=
 =?Windows-1252?Q?yKsyfnjiexm29KihrH+th09jcepgm0ZTSZzaGgY8xeX6g3XV0/W1JF0t?=
 =?Windows-1252?Q?CZp/gJBPDf0pTFoZlxLE96P6nOVwmrkcsbM+AUBG9b3HFBI1/K41mI4a?=
 =?Windows-1252?Q?LwwtN3xZjIUX1Rv/1hs6cOe/bj798fWcA31+WGAJHpvM3eo/gxBBy1CL?=
 =?Windows-1252?Q?iiOZc243g57HWhLV1LV5rh5HZlFnKf7LVhV4h27adO4H5cYdtvoEVTLt?=
 =?Windows-1252?Q?2Wf81QLWja833A5WwO6uXQKeyWh1vSlAGMl3yKRF92CFBI/GsxTXKArC?=
 =?Windows-1252?Q?Vuzzi+3YnUR+oMtOJxQgAsP594YddddP/U0WTC/7duEYVMchGEp2gPik?=
 =?Windows-1252?Q?KwHDRGfCVifruHtojtmTrWsgzx2NUu6zj2jCS08kIkFe61mRDUmv72UR?=
 =?Windows-1252?Q?vOJQjUkuFsvQ+37YMaxsgZMDoi5ymukRFjNNuE+ZO3e5ExFWDk9gGhzV?=
 =?Windows-1252?Q?+ModrmBB1vnj+BpzXZPsDo4WYamT1bv8AOM+HddTAENGQNx3Jz5NNxsr?=
 =?Windows-1252?Q?o04pfeHb5E3Hd10SOFfsArE5hxtX77NJuTcZo9t0Dx86wLgNj88qU3MC?=
 =?Windows-1252?Q?Jw9nKMJP5+xdJWraNIVvX/PvYfgH/IlvtTTw0QLQh4SDX6I3zJFXHi91?=
 =?Windows-1252?Q?r+xwq7K+q7osA1tPWn6Iad0tpV3f0Tb4LC9RbG7zDIaJiS/nrAGS4Wv/?=
 =?Windows-1252?Q?qQurnyhfDlL+NrUiGUUJ2KcI51pdLavomNjYAuM83MUvDASBiZn+Z8qj?=
 =?Windows-1252?Q?nhKSQMvQ2iWRuV6w3w8bFLoBkjwVc4FJVJJFtl6pexRlqhUqcZGCsOFs?=
 =?Windows-1252?Q?btMlM+n7PTXeZrtRXixVFkAUBGmrUFAWm4j0IfQPwCGBrfI5IWBcW+Bz?=
 =?Windows-1252?Q?47E+ot/CMKk64+GXvzzSevLgY0lmh0O3CJNoga8+jTumYRPtPkdk+eHr?=
 =?Windows-1252?Q?zNo3Ene3KayOVRt1xZMPtmxjnTkbTd39z+pW1FZ4zUeV30WrsOkBJUhD?=
 =?Windows-1252?Q?2RIrkbaQTr4zyLY4w4uRoH8Kbfu0VbBJf85kUdh+dSoJvDh2YsO/tPNf?=
 =?Windows-1252?Q?tSBAtm+LYQKSKks5rPoiWEQ9Vir?=
X-Microsoft-Antispam-Message-Info: xNANbu9kDLcEcbZs0uH6ZvE4NhUe9EOHNpI0691ZhDFeFNbgvnEnYjOGp2E34WpA18fKfdeJvugC45aoeLOJ+QcGSEste7cdjAveNbgivRDaVNbW29XphtHtnvxu+TDx0ZnP2s1gqFB8M+EqAB4l+ll0D8Ff8UnZwpXFChgSMq7ARomlBdzzSFpGEnl3F7yK
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2503;6:WNu/j7qSv+jZwxOA53PtY3vxWNFYFbCDda5d0t9p/G6GpYZlA991GQ2lFxh6XGa772Js52ts3QwYccfn1fwg+oAsAvDrcekvKuCEWBPcx4Cl0bNefivIPFrG2xCk7gl4gsfRYtIivRFuT2AjmQ/5Ol7bKFiYACriOOFuP2OFs+saiZZn5DHIQegSDetoBexd5eQSyk3lyo19S/LADbUsQMPwCR8X0+QRM+xa/oxYnLAcql2K1h4/DKuMfnhtgs0Q8H4Wc4wpmZsKoq2dlUKf7oDOXOeqvo+h4LxMe+x36tyZoAE4VeprPQR0QFRSjFRIhw11rCvR5APWfKThrubQpKbU3Mh5zQNrDINGEIA5l58=;5:vBb6cjw79EB68OYLDBBnyzLcXPohjMhrePmaahFZDi1dBVLqKbsdjw9EGdvHHtJBphSXSIxv0YHR8H8PGsNam0KMzi/c8zKa32qEoyve6fXCbE21FqvTFK+3JDgHIMyo3ouhgTogrouj5x8FRTdvVVpyNKsZ2UlLu8cpOWG4kAE=;24:saPKMVFQlJuB3IIN5J1W83LXzQPsdAN0mjtFtg83LchYJCYzcuDzKVCFgXHYZQPnh+dFX+gV3ygEYFpaPGHvna0SeigxrQG/uy9duuh7sS8=;7:NZgrj2zI5JN9WQeb3sd3FaWSrKekWUJN+LSAYQ9EbLGPTm4h55DLwKM8np7JPp4TgyUZGdFYQCjnVJJkHFRL75Cq/CjhlSEiwhexdv6B6xVwClQUFuvXbdxMpPxEucnFd9Q3+z5ICBnVOz9rdOsnCKmK7ap779BNvc6O69ti2TQu91oiLtb4YWXXnR4FbBQ4kLmP9nIFK7ckDjGOfM4ITrf/PiYpChFgs1n2nI+yIGVwjWouuu4kwKCLsJpV3JZU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2503;20:yJWiHYCZraYZvbBeyMi6000sIXsdnPr1F9AsiNwOnM7/9lOnGll/FJDHJGDh+5jWeCx1lL1WWLU3zdFjxAA3d3Bbv/zGh5M791DDYz/c9fZ1rIHMiA4uhmEdJVuOEyB9kkMqdhEgvqttK+qq2dmlyQuy+5GgT7bY6EtAFkNDhMc=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2018 18:50:54.6532 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5cda09c-5285-40c0-91a3-08d585eeb14e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2503
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-09_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/9/18 10:23 AM, Andy Lutomirski wrote:
>
>
>> On Mar 9, 2018, at 10:15 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>
>>
>> Oh, and for the record, I like Andy's proposal as well as dumping this
>> into a kernel module "blob" with the exception that this now would take
>> up unswapable memory, which isn't the nicest and is one big reason we
>> removed the in-kernel-memory firmware blobs many years ago.
>>
>
> It might not be totally crazy to back it by tmpfs.

interesting. how do you propose to do it?
Something like:
- create /umh_module_tempxxx dir
- mount tmpfs there
- copy elf into it and exec it?

