Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1185227-1520621978-2-3275360358208994164
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
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
    t=1520621978; b=OvyOzgofe1ISrWI0NwLw8mlr9YFqZqwL/pxgiD65FD3bkLI
    PKcijTIJvRIxDTMdtkWhy3l44o4zV3bFVrCRketdZVZdmw0t5GvNbaTBKuU/6W1k
    UGDC5zDhFzdWn7wrwhMAVMvpIu06qfesFOtJ0j6PiBNul1u33tAYnRTkv0AqY1kv
    9bsv54AASt6NsynD9Rjt65Iy52VvuzDasUEXctdGWCFzW75BK3AWTupmsybdQNp+
    Wqms1isfjlpa7Fm4jgKP8CbmAdAbuw5JXEAuN6i//X2OKQoX4N13J3Qt428FrtoZ
    YcjrD6evSx1yTBU6dMob5S1+zWcqSGAw4zDlUWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520621978; bh=nSO8mNFHMXSkGHYYaiPM5X6wlDsnNChqMEEG/+DbdEM=; b=L
    yx1CRkCX5S9dsKjx0VIvqTdAeiFmjAyYijkdK4E/VQIfo/xFljcf/KGZ+kmILa5x
    JT+7q8TrGW9MhaWAjT7LnILEkd6xPIW1yRHBYqpxV9xibYMB2P++zRC5iOj/6E5w
    KcvjvNa13ak1JuANkxjnpbk4v1KFQHDIWrDpd0Ut7qXIukjoOBiG1zLzuXnEZvv2
    UvEar1qUt61FWaTL3TxXqDwtXFO64/kJzKD2FwNsr3QtYz0B3GbG2sMW/MVufJQK
    OZ6XIYthypiVg/xAopDl9Ie0bNiiosNhV+xg+6n6tphEe8VPZquRmSDtcWD5d0CJ
    SnE69B3xFEeTI0wH7gOHg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=A8UKygUf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=apU/WUvm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=A8UKygUf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=apU/WUvm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932359AbeCIS70 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 13:59:26 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44214 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751205AbeCIS7W (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 9 Mar 2018 13:59:22 -0500
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf
 binaries
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
References: <C94A45E9-54A0-446D-86D6-82D06E2A35CD@amacapital.net>
 <87478c51-59a7-f6ac-1fb2-f3ca2dcf658b@fb.com>
 <CA+55aFwfcXzD+pzjN=vTcvscpK97pSztUZ2JK7pABs+rMtM7BQ@mail.gmail.com>
 <20180309.133509.1275903267249306409.davem@davemloft.net>
 <CAGXu5jJcuSojm_KN5+JQ3fV6J09V6dmNB6haqu11xkXTq=nxog@mail.gmail.com>
 <CA+55aFzJEkUGfRkKqc8twaDSdSH_r_OWnFm-e4uNQf4SrJy7-A@mail.gmail.com>
CC: David Miller <davem@davemloft.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Djalal Harouni <tixxdz@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>,
        Linux API <linux-api@vger.kernel.org>
From: Alexei Starovoitov <ast@fb.com>
Message-ID: <77cdc9f5-b51c-a18d-5422-763cc4e76279@fb.com>
Date: Fri, 9 Mar 2018 10:58:06 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFzJEkUGfRkKqc8twaDSdSH_r_OWnFm-e4uNQf4SrJy7-A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:200::6:ce34]
X-ClientProxiedBy: CO2PR05CA0088.namprd05.prod.outlook.com
 (2603:10b6:104:1::14) To SN6PR15MB2512.namprd15.prod.outlook.com
 (2603:10b6:805:25::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3dad86d3-238c-47dd-867b-08d585efb480
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN6PR15MB2512;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR15MB2512;3:t2NAWF+xTKA5w4QFArD0a+H39W7RP7STyhhBkUmVnwsQeppmsjvC2i9imnTMcdIMo25YgeSOHbUvOnAcLLIuNZCL/1SBpxQcvMnIJBfagQ1IvvPjoWz1iMt9piD3m5S+E2gRj2xIBpaEckLOJKcohc0yaXVfUQQkRv+ee6PYfbzEOTW0aUWEh/UK8rXG5iMhBjzi8Sdc58r71X2syk+wGSZ/sjyNblCF/3yfrlV+MOfdLSsuzFR/LwBVGYEmdY6W;25:xFk4XXngTggOZiw3mJ6F5Llbcag1B3A6iLDKljGPZ5cU6M3wUOr4UyBz2N74bj1IKcPrIbB47Yg/YlNXslqocXKK9p6J7sEBfxucS/dSJPeQj89f7vSuy0EA8ylVA9FPibz51/DuAzKNAYIiQ4ljuXHY9NW+VntFBvC/2M8nmHGeWhU3H9mWHBSUdcRXA0Njltl0bPXFfGAaihaAOUSQ1Ky6R1ivbn+wJP2UDmXAOjPjKy8DOX3ZhPIGxuaDIvQcLXLD5vbjV7ndj8asB58BOsTkcQsE72Tx82gc6KAziwWfpebMfO9CcoBaA8qyG+sqAUfHyPR+GX+42La7QVLQUw==;31:JojDnOgvU+pvBV90jWHbndq9dfdZH0c51CeHNppkYzBEdZhIV/NksDhrRCpJsHJTptPIyaCuQRZwmRjQYuTQ4hJ9H4h3RgIOL+W+dnheVdUw1Oft92s+Mc3pnAvmxgMkj/ojsXdKVHbZivMAnlzdu0qTmBUpWR+ulvtgfrm/zvZgJnC5lkAh7USGMgQ2JISFqPn7K3AteJkioOcitrge89GrPLTGg5qZz2aajERNIGI=
X-MS-TrafficTypeDiagnostic: SN6PR15MB2512:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR15MB2512;20:cG5ZIJCHLLhg1CieU6ui/PWW9ECP8s3KvyIaNBUeQTw431F03Ycko9qFbpuvPtrkGdQ8qXln8bp1VLu7UPfJsnvEN8A7VqXViskjWnUMhtkqW8Q1u/STQOQ0MTT6hwa3VEPvoMTa10sZ3329NlExMseznOCRENfB3ejPE8d4gDtlg3JN2vS6Pl1FTmHRxWrrMab/omGSnhQSbl2wuRVIJCZ5vL2KvQGZF3sBirUloZCaLj5SaaZb/37OaCk4W5bWKE8q09wCAzs+dGKvLHr/MCv1QehkpUW1NSBY7mF+JaMYvLVMG9ttXFnnhJWDcJopLKpafD3VuRVSGIdzuqwhUg7E321r38ercG4sgdG0Y7iN6aHeQL7Or8ztu5wuPHtlSSjTy+djx6oZ316f9RTbaIWGJ1eOfon7hnRW4uAPBkLk2hsCv+5cGxJ0YERgOqRtwiMIWvQALUm2Xdxd1FFMdPAE/N2pOqlQRfVjCFGbgqESUNS/qNTx3TM2xO5/SOBr;4:w8CJw0hSkmiGHdXMyZMJMG0Jdmhhjd5DeE5+PdWslGX+Xv5TrIGYstIPL2mArYozqto1qohTrhowxl6vLdZjbsoDDQPdqtHbYIm7tyhdbT/hslEkmbBUZukt1kQLxc4oUu/VpaE2J3ka6jsUFRSUpqzWw1KSi8cN1br+xknqN0lLw4Kzuhdoa5qAgeZppmO6AsUdOD+cKriGOK/veHp0D1YZvs8SYd9LNvZlnzyg5nJWJzTaPgPyQMW3StTVmEkr0amF3DeIR9gCJokxd1eFrQ==
X-Microsoft-Antispam-PRVS: <SN6PR15MB25128A86D180A37D0591B509D7DE0@SN6PR15MB2512.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231220)(11241501184)(944501244)(52105095)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:SN6PR15MB2512;BCL:0;PCL:0;RULEID:;SRVR:SN6PR15MB2512;
X-Forefront-PRVS: 0606BBEB39
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39380400002)(396003)(346002)(39860400002)(189003)(199004)(97736004)(4326008)(53936002)(230700001)(25786009)(478600001)(59450400001)(53546011)(64126003)(386003)(229853002)(6486002)(6246003)(47776003)(5660300001)(39060400002)(65956001)(65806001)(1706002)(36756003)(2906002)(6116002)(7736002)(50466002)(65826007)(8676002)(54906003)(93886005)(110136005)(58126008)(81156014)(81166006)(86362001)(6666003)(2950100002)(8936002)(31686004)(316002)(305945005)(106356001)(7416002)(76176011)(52116002)(23676004)(52396003)(52146003)(2486003)(46003)(16526019)(68736007)(186003)(67846002)(31696002)(105586002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR15MB2512;H:[IPv6:2620:10d:c082:1055:7184:6abc:4304:f18];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjZQUjE1TUIyNTEyOzIzOmlseVgzcXZwNENCTGlvVjg5Y3pKa3UrNFhF?=
 =?utf-8?B?VEtBVzZzUGpRL1hBQ0hwMGhUdEJaWnorYndqb3RyaTd4NWhuRmFuTmlDUTFn?=
 =?utf-8?B?aHl3ZlhNQnRheDZOS3pvU2ZOaTN0cXpPTnNNcVgzQjErUnJWeHU0OWFTKzFE?=
 =?utf-8?B?R2swZVJGdit4eWxhU0tnc2sreTZRbHBHODJKZGM0dzBBSWx4S25kOFAzaFJZ?=
 =?utf-8?B?bHVneVBERVI2dHhnNEU3TS9ZWXQ0eFduK21kam4vRm1ROVlpS2RqMW4xR1I5?=
 =?utf-8?B?ZWdNSkpQVlhsNkJpY2VWZkQvWnl3cU91eXpzVzg4SWZKUTZaaGpxTUMremlq?=
 =?utf-8?B?ZzBKNmtNbUJKOU5CdmdlK2hLcVdyQnpGS3N6WlZ6YWdtaVRBMjNWSUVCa095?=
 =?utf-8?B?dlZwdmZocGZhZmQyR01iRllQdjVXY1YybFhPcGJyRlNQTG5JNDVDcWlhcVB3?=
 =?utf-8?B?alQ1ZWtzajAzZWhHbW1POVQ1WVVnVW1pcFRKNHpjd0RIVlcwdmk3RGxQd05a?=
 =?utf-8?B?Q1gvN0VlWmZzN2Vyd0RqYStVK1IvMlRpY2JVS1pCaWd0Q1piTGpFN2xJTFhz?=
 =?utf-8?B?TjJIOUlOaFN6dmVUR3R1YmpJL2VKSHlPeDBMcG9DdVlxZ0RuemNJdk14Vkhz?=
 =?utf-8?B?dFQwMFl2S20rZkRIcm1XRG5nNFJGYVZ4Sm02aWxVcHFlaCt4Y1h0Um9WRFNi?=
 =?utf-8?B?SmhiSHdkOFNNWi9Kb3RkQ015SG12Z0hYNjN0alYzUDNQZ2cwMHVHN0prUUtK?=
 =?utf-8?B?SjY1bkdQMnZXRWFCRGRlVjRRenI3SDRCNEEyMmg4SUpqUmx1WnVod3krc09Z?=
 =?utf-8?B?TjNYSzQzcmVvQ1I3UkpvMys1SHQ1UnJQeEpZVDlvT24valR2SVc1M0U0WHl5?=
 =?utf-8?B?b3U2dElBbXpDZHNPbkYvNjRJZFhlTkZudTZIdWZGVWtuaFdXcmNKYUdya29E?=
 =?utf-8?B?TmJGRVF2bGZMSUYzS1hCdVY0MzFNRjFpUGNkL2JKa3Bpa21HZWYwVjVqNEc0?=
 =?utf-8?B?bktzdnZIYXpvVzZyQTdtY2V3Y0h5dnUxWHJ1VHlwbkJuRWJTaFZDTUlWK3VN?=
 =?utf-8?B?RGpkR0ZaRHBta1B0Q0xEZlFrSmlwRTRTTStEQWhXUSthM1FhcHEyb3VuQmxQ?=
 =?utf-8?B?YlptTXhhV1N5OG5ZSld5NUFMMHFhWThJdXJjVWQrRnZjOHloM2VLNnBBd2xC?=
 =?utf-8?B?aVkvODI5M2NQUlpBZis5bC9JMkR0TldWWGxTZzg5T294ekc2eE91TFZOQS9h?=
 =?utf-8?B?RFhYRm9RODduWVpZdGtLRUpBY0NLY0lTMjk4bWlBNEJVS0VIVGcvYVF4ZXd5?=
 =?utf-8?B?T3FxOXlKN1liTDQ4R0RpbzBpZXovQVpVWXRHR1R4azJkSFlDcUlvMTFNU2d1?=
 =?utf-8?B?RlpHYzdQd1hSb0oyOGkxR09Dc2Y4bW5IbUZlR3lzbkYxMloyeWRkOUFuclFo?=
 =?utf-8?B?dVdxbXRnazVjaGU4cHVoc2pMc254VGhLSkdTb0pUR0NWSnpCeE8yU1Y4bi81?=
 =?utf-8?B?amdsSUhMOWJNREV5VHdRaUVqTXozZCtWZmlYczM3TkxOLzZZcEtQRGpWUFNv?=
 =?utf-8?B?NHBnQjdMdHRhSlRVelJ3aUxTaFUraTd5TG9yTTVoVmpVY3d0VzkxRDBrMVJq?=
 =?utf-8?B?WDcvVmxDRkV0aUFLNU9wdXAvVUkvL2ZHcUYxZ0YxR1VmUG8xMmNaNldjOUpa?=
 =?utf-8?B?eWp0MWx6OTJxdS9sRVM0ZWhGM2t4ZmdoUS93UE1WdUNUcnMzQ0JRWFhiNEtS?=
 =?utf-8?B?ZGN2aHdkR0QxUjRTUkZ1N01nTW9WOTNiTDlONzVjRmlKTk43NS9SZ1MyVnRl?=
 =?utf-8?B?a01qcHk3dXcrSzhkOG9QaFk4YjVPeDJnbTFHN2J5WEZWc1ZBZjhSbmJEd3BU?=
 =?utf-8?B?dEsvcE50bzYxc3F0SzQ3bmNPZ1U3RE9YcVE5N3pQbHUyYUlzeTJxelRNanFr?=
 =?utf-8?Q?5vvxFTGAnmJ8sIssPrx8zm/ctrC0dg=3D?=
X-Microsoft-Antispam-Message-Info: oJXpO/u6mwwNk95lrx3rmIUi7WP2s6ijtmNLIr8nK6964VCeHQe2A0Vfz57r7aoqZBf/wDa6COwC4s5VlYsPVI9WYpqv/Z75U2m4eOKSjIgl/Lkfet4KDAk0r9NyPUcUGXOeXob7GtIEb+M4JgJQcMY8RbOBO7wXG48kCM5zNjOwurxSsor4oXeCbfpXDBoY
X-Microsoft-Exchange-Diagnostics: 1;SN6PR15MB2512;6:oJ+zw1Y6/AfPqakU5exUbqh5yC0QeRHy5jNONCbSjeNCkmyEwt3Rcuyd9ZnaPJBKVDOE6HRFrpPShbgApn3h70r+g1nahPaz1WMtIfGTeA/Mb45hTNinHcjZKE413Rtbtwzx/ZfVlamXqAmKY/XrqJACJYHqwafbHlgp1SsLMugMJoj9rVPoQGJUqHmw30enwk5lWt2mmNdtv3lGTLVSavKwXKYgy3uU8sXuKpJqAKBGhBMYdfOu+EvqugkTyYx/m1OFm/UGlaCn2m+hxxojzjZcz1JB+iVDD6Rnt0HurqTfPZyOhoiXeFw9Nb4BtSBiLobyQFOp5T2r/j7J/QveR6f1E5a7H5ng+/mTyjaQSUA=;5:vSWkQu1+wlVFGJbLDO7ATyiB79p/Mmd97uJ5NvIvEqtZyimLbBLGUg/1/mZPauRW3MCL74yg9ztnsBhaonRFByy02NFcHmd6GAsFMKzvwSzUPmLr8qrOj/T3IHvjMTeE7C9T8m74+gzDUMWPCabp/YDJ9rdKDvjLnF4vK6amvHk=;24:xCe/yoSc83bT6sEtIFVMlLAnTCF4N9Do5nlvs/ERBq6ff14pKZa6Nab+9qmOrExRBlz06Sgj4WdsEoJvz8U8hFgkO5ZN8j4oJ9+ZJNa7T3k=;7:ru7M1BRYrGHX7M2UTpMmN4Px5CBx6dFQhteHpfWQ/P61zLO9jBQFY4hvpRk9xyXoudYdAvuFTXU0u6tfOcKWCa2aP2Kt/kbngWZkRhwXz5/eIzskAeEmeoNH5XF1vY6OICA2QaTfZ+eDA8TL3TWOPurut0pjXI6kk8aDPkj5I8IBg7aVAx6Y2wLuyeIVekDr7qefLFC7Gmz+6ztsCZH3gYURfdzUX7pMfFiZP5eU9Yv8wpz9ox46A6Zk5o+Fj5MI
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR15MB2512;20:cfGABe5N5vbwA6XBez1U6Q6ZnRf+o+ZBSfnyRroayEJWNv8DY7srFz2gDLorC398gY7SDo+nkSIZ4AEdqv0hUfqIwyv5ZGv/O4bSuBLbMcw2J+qGsLlts6PCEWJDXZfVTWwFxCPKBuuWiTJ1CVx/2OFG4i5aDp+68Rn+YrhN6Gw=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2018 18:58:10.1668 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dad86d3-238c-47dd-867b-08d585efb480
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2512
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

On 3/9/18 10:50 AM, Linus Torvalds wrote:
> On Fri, Mar 9, 2018 at 10:43 AM, Kees Cook <keescook@chromium.org> wrote:
>>
>> Module loading (via kernel_read_file()) already uses
>> deny_write_access(), and so does do_open_execat(). As long as module
>> loading doesn't call allow_write_access() before the execve() has
>> started in the new implementation, I think we'd be covered here.
>
> No. kernel_read_file() only does it *during* the read.
>
> So there's a huge big honking gap between the two.
>
> Also, the second part of my suggestion was to be entirely synchronous
> with the whole execution of the process, and do it within the "we do
> mutual exclusion fo rmodules with the same name" logic.
>
> Note that Andrei's patch uses UMH_WAIT_EXEC. That's basically
> "vfork+exec" - it only waits for the exec to have started, it doesn't
> wait for the whole thing.

It's not waiting for the whole thing, because once bpfilter starts it
stays running/sleeping because it's stateful. It needs normal
malloc-ed memory to keep the state of iptable->bpf translation that
it will use later during subsequent translation calls.
Theoretically it can use bpf maps pinned in kernel memory to keep
this state, but then it's non-swappable. It's better to keep bpfilter
state in its own user memory.

