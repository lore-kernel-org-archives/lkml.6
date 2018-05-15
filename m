Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2852936-1526400519-6-623239184651695978
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='windows-1252'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526400519; b=kTW8L6bt06UCvinhGsKFaJXZBKMiIOVCY4nHvc1jJz9Z78iaib
    Nsw/fKY5qaI+iX8v+Q0UY6vnC+8M2SXyArX2DfxvczrMGP2syT6+3zucjOR24izy
    OgIS9Ew4qBAUuFg6cRNxo/4nTi+2OCzJEc52ftbMeeOBXFcTmas7t5zXdE2i4WMM
    ssnLcQfu/SmmELO2J0ifoxFmpk0Sesf+ZyrMt0i2jvmG6qm16nnmaMPdAHYZjniU
    /ZlccTo8ujSR94KIitEOd5RJAw1qNjG/E5BRXOv4IWdiQ2OUhK6nMrTzvUzeZcVi
    DQ4OGS0II4FmaP0hqNkJyjNJyYwD3VKwalKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526400519;
    bh=OMyLtL6VeGwq6MjGgKT0Jq71/x3Y+tT1JJTCckC8SS4=; b=Px+IIPdHzg2S
    CGHHbCY3MNKDx3G6+gpBKcBILjApMgmiuFjkQ3CFPlqJHUJZyVpViSrQTJd3TSKL
    jN68QteqakJz4Tig8VuogjZ/iFgvW7Ejahgf0dx/TH+64REfKPeIZ3qlxU2n3NB8
    eUUUl5fLZUam/8BcjTvvw2wrOJeBjSXZTYq9LhxAca1U3mWy0Dqhx5k8afupms+m
    +v9L0Njqwgiq40UIvMG4Hfnmhh2+j+hvyOjZUhCvSuThuM2jRd1kOKhAu8Y0F/NX
    eWU7VnuMt1QiIMJT8z7rDQw3IKBSuuX+kU7KP1gYJE601jkc733QyR8gxFTtnubY
    cWi+I5ylYw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hpe.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=hpe.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hpe.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=hpe.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB5VHR2ShuzTTy9PVit82ojKUxOnPkosKEbEd4Uf+TVkvrrXx5iDIE+ecduJVxIP4JOb18We+mnR4MogeMgNAsILT/y5QYBrGcydMKH2M4RYjrhUq3si
    Ok4cJK6iDsWYvpNaH0IWR3J0SF0nTDv6znVRa2OaItzfpjPrewkUPeQj34Z+AC9+++kL6hOFvvv5aLLt1awm3YNY4rKdKzpCXSKx31kw3ITELJuugS/PLwGR
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=hXT8ZEcGov4A:10 a=yoEhkbwvSg8A:10 a=pl-7K9XT6X4A:10 a=N659UExz7-8A:10
    a=VUJBJC2UJ8kA:10 a=QDZ4HvhdkI4A:10 a=MvuuwTCpAAAA:8 a=OOx95MynL_vNfmb_E4wA:9
    a=zd1NP33qi-2YF5m0:21 a=bQses6tug_mLbLYW:21 a=pILNOxqGKmIA:10
    a=dVHiktpip_riXrfdqayU:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753995AbeEOQI3 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 12:08:29 -0400
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:10868 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752454AbeEOQIZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 15 May 2018 12:08:25 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=mike.travis@hpe.com;
Subject: Re: [PATCH 0/3] x86/platform/UV: Update Memory Block Size Setting
To: Michal Hocko <mhocko@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Andrew Banman <andrew.banman@hpe.com>, <jgross@suse.com>,
        <dan.j.williams@intel.com>, <kirill.shutemov@linux.intel.com>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20180510231832.035433756@stormcage.americas.sgi.com>
 <20180511064837.GB23231@dhcp22.suse.cz>
From: Mike Travis <mike.travis@hpe.com>
Message-ID: <6a67bfcd-c80f-b0bd-aeb3-3c8d27d45e88@hpe.com>
Date: Tue, 15 May 2018 09:08:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180511064837.GB23231@dhcp22.suse.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.48.179.6]
X-ClientProxiedBy: SN4PR0201CA0046.namprd02.prod.outlook.com
 (2603:10b6:803:2e::32) To TU4PR8401MB0815.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7710::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:(222181515654134);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989080)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:TU4PR8401MB0815;
X-Microsoft-Exchange-Diagnostics: 1;TU4PR8401MB0815;3:KK0shjC9cKJz4/wssPtX+WW4c3IlH0cS8G+joZiTVShp8mmIFWf2fZpXDfmcF9HMu5VUZ9T4RMPUMYXbRM9EN4BDbwd8BsEa1fxTH5UP3nycZAaKm07OvOMVnZb0M4NpZ7PzHGft4oVnf/sH0Hma3OxAHj76sOFq/9TeFh1CXKsA+/ibgKKs0lu1AitAjFZfSScfTCuddCHZyby0rCJv0/g5Q05Ag0x1ljAVnrqurunJehy7fb4dy7f4ijWlIdI3wDfskk3MtfiwmFlFv3aK9Kop5xF3tJBx3lfJj1h7e1E=;25:+B4CDjXkONG1DnNeres6vMPvV7+bo6+aM3j3zjjAW2jxqc938VbMup1lhSiQnJ+kyj0h9ozV8V7cimdGgH4/+9AKYzyrB8Qzrc2C3+sZZurun8oIXDj2UGtJgtGPtwsqMGeFiXePFXNDqLOMEfYyorltXhuqRRj5aq9BIViRfaqMu7jBsT/So+xwF0cNyL7QW0sw1GjWuJKy6hhXmUpXaOvObJ48b5OLBecrEUxQTAY0OyIXiLEO19NxvDaQWg4MavbNmSUqIQtwPl43JU5/sVhXNIMqOOBAIg1bqrxLVkBg8+2s+gwCClXP4ZxyiiktYZgjdKDe6XenByc6WT532g==;31:ePsyvqbLzU/OOSrsuZjJCai3GbbOfAAcAjiPwr4mK4uZA7L2hLuj6xHz9EzyqyZzujCDmux6iN/+YAV0R1J9V/feghqfy358713x0NrmNEMYVEgAuEVqUW67J0ezR3Sh4khGd1w4kFJEeaj3T/8S+f5vyC2ra3XTZTehPmU4g1D9cl6HWprQLGygMJgO08yc9S0B5nhZ9oddYnz6Ol3HLUfYkwuS2P+jdlMvr0xPGwo=
X-MS-TrafficTypeDiagnostic: TU4PR8401MB0815:
X-LD-Processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;TU4PR8401MB0815;20:OH1ZGav9rEWj4TKa5PEOXwJv8G60f5R8NQNv/jBhCNDWke/ZBAwM97pF6R39J4t+XtuEPwE9LQCF24hzv1MzADLoxVj26guNMMfLlxoxN8enf6zkjMDCD4OMKqu+6AVSzliOZo2dSSxnAtMk5eIIxX/rBGVz0jj/PMXgGwmu/YwW063P3cco6BZDZ4RM7ioQr8zVyHEaE+cjvbu5Vm0KxB27rAWyobW1TPeEGwDY3AS01B0Cl9L6ZSIhdgsc0xQV9RdTyC3pAsmCH10XreLXFhMvJNrbsqI43+1NQi9HJ+TXE9NMIxGJYL5k4+nfwQXjwvgkBgsYivriJWm8iLt19V1/i4EMUKKYbgpKxE+W9kNTDpEWL+1KJyPO9rAlrf7KfdV3ohLKaRVv8xsbz7ZjW0knNUqpuDJApCmWjPhFaKBqahK7M1pDjVzQUTZeMIy79fN/v7eMRiJ/TdaBG5kx6gRl2Q9cOxWGn/FbVTV0geaLlmb5d7OgbWrzWggIhbiR;4:C6HDhZuofWfDq6mtgnErdLfCIpOyXZ0+VGlxsNZFrqzfigbCKTFYsFE9JJZk2XWMZIkW53Uscqc/VwqT/8GiNc3kRxp8jdTTsdb5Yd4aeDA3lAQ11QBMqHcvRSguKSX0EWWQYS64GCsZGU76BVvxIcMn1kfzPItQcAux6jtEuxOSY8AGOJlhKMwI+PU3HmPfMM+RP/UT62BH/egmQXPnPdsyJpTgOQUoWXIn+AfH0aRGTR6nK24356tIrewaZlsGvFaBl2XGptzl3VTKcQyAZsWD8sHHVqI6EfFSY/TlgCZ9snmAxUtFQN9BcO39Vh2dtYlA32HDR8F/f4Nyldptcb+f2H7f4VkyGqrV9K6qmwA=
X-Microsoft-Antispam-PRVS: <TU4PR8401MB081539D8873422748B5B0B36E7930@TU4PR8401MB0815.NAMPRD84.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(227479698468861)(222181515654134);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:TU4PR8401MB0815;BCL:0;PCL:0;RULEID:;SRVR:TU4PR8401MB0815;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39860400002)(376002)(396003)(366004)(346002)(39380400002)(377424004)(199004)(189003)(47776003)(478600001)(64126003)(6116002)(97736004)(7416002)(50466002)(3846002)(65826007)(36756003)(58126008)(446003)(2616005)(23746002)(66066001)(25786009)(316002)(3260700006)(65956001)(5660300001)(230700001)(16576012)(65806001)(54906003)(11346002)(476003)(956004)(6486002)(6916009)(486006)(229853002)(44832011)(6666003)(31686004)(86362001)(8676002)(59450400001)(15650500001)(386003)(16526019)(105586002)(106356001)(81166006)(81156014)(53936002)(31696002)(6246003)(8936002)(52116002)(2906002)(67846002)(7736002)(305945005)(4326008)(76176011)(26005)(68736007)(49976009)(53546011)(78286006);DIR:OUT;SFP:1102;SCL:1;SRVR:TU4PR8401MB0815;H:[134.15.1.253];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;TU4PR8401MB0815;23:GLzY7K60qrOlWRAaHh/VZmjLP6C9+eYUphd?=
 =?Windows-1252?Q?1ZeybI395FWYbkZevNJdJS5xrQzDfEaJsWb3+Zsvrj1sGCvGo9S/iJnt?=
 =?Windows-1252?Q?evOCl1w5PdQ4IMOaPKomn0sDN2Ul0JClbdVo6Kas6IDSs5SxU8wZIfX9?=
 =?Windows-1252?Q?kCRPMiUKvPmYB1cCk/7udmQW+kHC1aGZeC20s2s9Itb+kSvegRP/sz/T?=
 =?Windows-1252?Q?QzvydJUhWEvWYEJQ11rvAIUUlspbg8SsJEiaUF58rPMH9LkQUydmPC4h?=
 =?Windows-1252?Q?amvw+Jh+PS8erjMsekGY8EEudUPUa0wHckzn5nQR+7sbEWeaX3VIaq/o?=
 =?Windows-1252?Q?F/F6EZ2y0B/umGhBdV4wqmP7F9tNyrpbexQdQdUwU6Pf2WUl6C4v/8Bp?=
 =?Windows-1252?Q?kiko0PKCKoK5Y2+0A53op/oeU3VIUyYsp7rZY/7K3bL4NJiq31LbMSS4?=
 =?Windows-1252?Q?0+21NGchxS6dv8gUZ5qYVqHt8cUue0RejOHIoUMdL806pn1cvngIjqoQ?=
 =?Windows-1252?Q?FGhoUj7sEDb7ree+krDLaWTcvMaz19ymmiGXsAfjsNWDOmkJnjc0mAb1?=
 =?Windows-1252?Q?Z8s4WMPpa3DTwmJQy//XcH5HDwRilmfckb9TUMyAypu1tRnGjw+FBKxg?=
 =?Windows-1252?Q?N3aehs0cPj0a6duXGqNZ9wkJWQGoDnXMkTgXrFJUpqyJXbEXVbRMJKpP?=
 =?Windows-1252?Q?sm8C4F0qHOp0YijQjI73DGJlM0L54/XORGitT+0OSIXIUqOsHnyffHva?=
 =?Windows-1252?Q?5H4e0dwNp3fx9VQPjvvvrBLkF/rJZbNUjvG/kgjZgm1HafP1Mm2VfFUE?=
 =?Windows-1252?Q?Qx37292q+Q+CJnnfqF50gGm2itonaYQE8iphY6yOlG8bWNwR1yDoX7bj?=
 =?Windows-1252?Q?/Ux//chnlAdQMwhSIYGaBDVo59m+XCHH2ChuOU36vgSaLliso2bvBHDL?=
 =?Windows-1252?Q?BpvJSpPVFg8xTruS0Vc01+y7wyIoaUkaRCJAlzSPWEjX3MpwqntIRxk6?=
 =?Windows-1252?Q?HdF6BWARQ2n3ilf9azJynnp85ZUfCRWES+K3HQQ8RkhxlPRziJYjJt5U?=
 =?Windows-1252?Q?Itvpi06Oxz0uhRBmFr9G3pmFuTnxte2yWZF58wykBw4sIDCffHOjpw/e?=
 =?Windows-1252?Q?xgC0j+45aMnhgFHLI6CGaDAmiUZZ2/9V9VWwwwy1cY433IX7gB6Ru6v+?=
 =?Windows-1252?Q?xhwXnYd/BUa7kdlYf/srwDab622/dSpIFt2bbOJ8WBG4e75wIT5m5mvI?=
 =?Windows-1252?Q?UaCeO/tIkoO3reYf2csw2I3sCiU0TjG6hrSDK+XnhAwzxcTgaARtniz3?=
 =?Windows-1252?Q?xS+Vk+21TyRNkx8Zh5l8rqvmgf3k/9IKFuwleJCvx7356iW7VE0i20Ia?=
 =?Windows-1252?Q?3llmqd3WzVHqQHh/fmPp4ls2v3skSM/uLtb0Ykz+HMQLlKxYpVtguEXJ?=
 =?Windows-1252?Q?VA059qGAqOTYynaB7uSJqnKOfcaOr9YA6gaSvRRoWJVBjXYWCE44T1m4?=
 =?Windows-1252?Q?ALCaiu48wQfkwy9Yu0DpDv7bBTqbZ9GYEyJiZpVVl0SrfU4MnOwVhB3Q?=
 =?Windows-1252?Q?MkPqZjCJ2km5B+SiH4T4Jz++agKwberrowapRtkDnP9dXlMrYo4YT43P?=
 =?Windows-1252?Q?f8rYoyJJbq54gAn37l9e55zQADnWK/WQOIPfqAbY9C95Xbe6ZEUBubNY?=
 =?Windows-1252?Q?ob3aGT/0GYADm3a+SOS7QDjUgGkstlnc=3D?=
X-Microsoft-Antispam-Message-Info: HgY7Vj4TrLfHWqmQP5J0ORU41vApzlQZeFbU1mBtSZu97HqLi8WQVGw4IVNsEDKuCQ1eBDbufHYLYjOoN0AoOkEpYJ3/ERmzxXdM0kye20XKLkCnhn+B7UhmeCw5JEMdr2t9s8et0bykO0lPYijjxVIqZvQ8tsdABYycpMKVS3oq1644fvY0CAQevJr/ugOe
X-Microsoft-Exchange-Diagnostics: 1;TU4PR8401MB0815;6:IlmTQXAbQHYFR+iaeZ86tUaIuFJwL+xQMLySmZjQApRqfWavBJIIqRW2XvPaoWd3GPyj7cbOIXrtl5IJFx7sHaAp/Ml/CveZNa1Et0fRWEWucKWsuNGSIRkmgifOm21IvWDnc0kodYUQyr4KhyQzrdeJAK8TD95V7ACvK3V+2tUiNgHqQKaFLc2MwTY6kfj70txyLV8tOqtV00dXhh6ahLDUpX1i5FMfUGZxpz0S+HnUVn+JsIeX5N5zHCEzzOtk1x2JORVc0jsUSnXX5BrjGSwUNvRxX0rKAl/lM+Re6cIB4G8bIxwsYcDGzy49l3WYVo+WkoAArlAlEfyWaZpnMlJYTU9dfjela7jVExzETtwGBJlQiljd9yK9VDesWQC9YukBHLj6mvSenlBHOnwL+bytD2b7h6Wlod9UquX00e34UBN2YNPRaOUKHmmepkGHeSGQGJMxXaGRX/vGVwJHXQ==;5:Ca5JVrsf9hpXPclGJhW8JP3v778+UNSaWbB8btUfjIZAn/iTeNUJUmaRh6NqTnSlM73nxK6sWHkljbSpB6uBzJMd2sb8f80V118tYqmQz10rPIEzzXY0H2Bl2ojnviOAltN9igv2NOzFfiD69ETmZmqyFv6rIWp9TThwNz0KPys=;24:BRJyoHeqU5RuQo4qDuwylAQ1zRMM6rlgljW/9JYuv1oPiTWVqiZXVD+sMklS2Ri4OeK2jyQ9WTucH6QwT2KZ+K+bPMzWImbc42Y4kY33NGY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;TU4PR8401MB0815;7:tR2WLMJyXmDEW5wCOmMYOUOF8pxxOC9YUVvXBOATvkzBPhQcH1yttFHU7xtiIfoU4YWDGC5N4G5Sb3CheGXu/U/2hSehoU0osLNCn5ckWvw9ns0N+Ws6My4SdKjHrjLlxb74Z/GhY81MYPmxzfLr9envInkrcpXNnvGoAturqLV/nYA3/fWMpQL+KPaM92qkztKDBOCfTeRV4kPrFAc6kzQU9YEunJY6y2BmI/M/t+N6OpFcAzOacpEsOHuogIMF
X-MS-Office365-Filtering-Correlation-Id: 935fb007-89aa-4205-4c5d-08d5ba7e1466
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 16:08:19.0874 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 935fb007-89aa-4205-4c5d-08d5ba7e1466
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TU4PR8401MB0815
X-OriginatorOrg: hpe.com
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

[re-including everyone for any other comments about these patches...]

On 5/10/2018 11:48 PM, Michal Hocko wrote:
> On Thu 10-05-18 18:18:32, mike.travis@hpe.com wrote:
>>
>> Update support for the UV kernel to accommodate Intel BIOS changes in
>> NVDIMM alignment, which caused UV BIOS to align the memory boundaries
>> on different blocks than the previous UV standard of 2GB.
> 
> Please elaborate (much) more. What is the actual problem and how is the
> patchset addressing it.
> 

On 5/15/2018 1:55 AM, Michal Hocko wrote:
 > On Fri 11-05-18 08:08:14, Mike Travis wrote:
 > [...]
 >> If you think I need this more detailed explanation in the patch 
descriptions
 >> themselves, I'll add it.
 >
 > Yes we definitely want this information along with a high level
 > description of how this got fixed. Incomplete memblocks need to be
 > handled gracefully (especially when blocks are 2GB in size).
 >
 > Thanks!
 >

Hi Michal,

I will add more info but this patch does not address anything about 
incomplete memblocks.  They have existed in 2GB mem block size form 
since 2009 (v2.6) with the first UV1 system release.  I am not changing 
any of that handling.

The fixing part was to adapt to what Intel BIOS was using as a different 
boundary to align the PMEM NVDIMMs.  This is explained in both patch 1 
and patch 2:

"Add a new function to "adjust" the current fixed UV memory block size 
of 2GB so it can be changed to a different physical boundary.  This is 
out of necessity so UV BIOS can accommodate Intel BIOS changes for 
NVDIMM's, which can align these new PMEM modules at other than 2GB 
boundaries."

"Add a call to the new function to "adjust" the current fixed UV memory 
block size of 2GB so it can be changed to a different physical boundary. 
This accommodates changes in the Intel BIOS, and therefore UV BIOS, 
which now can align boundaries different than the previous UV standard 
of 2GB. It also flags any UV Mem boundaries that cause a change in the 
mem block size boundary."

I can't explain why the Intel BIOS changed the boundaries, it probably 
has something to do with accommodating other areas of the NVDIMMs 
physical address space.  This caused a boundary alignment to be less 
than 2GB which UV had been using.  From one of the UV BIOS engineers I 
found out that Intel really only guarantees a 64MB boundary (which is 
actually less than the current Linux minimum of 128MB.)  Our own UVHUB 
requirements dictated that 2GB was an acceptable boundary up until now.

So let me know how much more info is needed on how I need to explain 
_this_ change.

Thanks,
Mike
