Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3239998-1524145787-2-7927708344964084232
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='RU'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524145786; b=izx+mRMDLnzsSmdzt8B44KOYPSRhQp2BOM7xWOK5/LSPPh3jWz
    RfnJma+IfH/EOFHo+2DpaZVPdYzSSnBBXk5zsvwI4Xt4jE32c+sfGdkGQB9t16Ss
    9H04UC6jPiM1hSMCTLIKzGuT+ij9166nnngswmCS2sYxdus5RD09RhK8ZRIDYbjn
    cetvydQfeNRBYKk7xh0fXmJcXDElCGprU3zqZspEHNZ+izu3VE7+TaAW9bOoCHbB
    YYhWdcN4MG5OQBt+swITOHd6nAiA485NTcCLbkR8IRB71OgmpZNLd64SzUZ6PCr/
    i6JC5zIj6zSj5PJPegV4bAklpUxo8BMU9WMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524145786; bh=mwyBT
    TDLJpsGDI8J9Fiab5ik2QsP7kDWcjyL5XYLOqM=; b=Hvi9kU+vWjk8lAA2GJQX2
    q1DAgknAGbk4UglMEGMcunOTiAmzWsQOY0i7ZV2mbY7z8bHjWTy2Ne3oUgsdxfTf
    J1sGQtZSnmX35SnUsssZFNGbvy1TJeSYde95KF/GmbJWJm2Py/bpLsWBIr0ThHUv
    FQhY0PpL4z04kU7TehHOfmcQfnVC2UOM4B5oreR3yhAWy6G2ElnQ3QklVTymZ6Jk
    a6+ixD85ikqyJP5rpqEDAHeVpHGKWR50hsIBDKpVXTPj5IVanPVuMhf0N5dzVGFY
    i+Ot3JSrLjOz1jdYshWu2R+juc/BRjFTcz6xrTp2li01ecUJ0l9yMO+uU6Zom6LO
    g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=TN994Ccj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=virtuozzo.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=virtuozzo.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=TN994Ccj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=virtuozzo.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=virtuozzo.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJTT7rklfPZhKTVkSqyI3StlTe0+LmTdZ01TcqmiXp3inw/jHtsjetZ0V0eSu2hzZFnZxzBfL4pkzYAyd9lj1CT9ejVOvEGD+A3kVRQ3lGMnHrZZcKRp
    gyc3o/NVhBZ98npXoRk+SJyC7hHlWz3KC4iOkOSv2mUgXe5CSTqAdTup5WAanhEYwR0e5ABZpHD0rVH2SEMHER7xF6pmS1T6FWIZ8h61RU0JeQqHnf8jPDoK
    zWMUO5Yk1BeTY5qCmtzveg==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=dhh_qWxcV0sA:10 a=Tgzm40sRGssA:10 a=D6hQ6p7FaAMA:10 a=kj9zAlcOel0A:10
    a=Kd1tUaAdevIA:10 a=tpEzL2_AlxEA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=VwQbUJbxAAAA:8 a=0Zu1b9sXAAAA:8 a=DDOyTI_5AAAA:8 a=ddMjj3PsICsCB3HRVD4A:9
    a=AW5Zo-io4V6G8fgz:21 a=QlU_W-C9C3YBXkOi:21 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=qSzbtxJfSrve39XLlx6B:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Authentication-Results: 01.org; dkim=none (message not signed)
 header.d=none;01.org; dmarc=none action=none header.from=virtuozzo.com;
Subject: Re: [cfs_trace_lock_tcd] BUG: KASAN: null-ptr-deref in
 cfs_trace_lock_tcd+0x25/0xeb
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Fengguang Wu <fengguang.wu@intel.com>, NeilBrown <neilb@suse.com>
References: <20180418133831.uef7d77ejdyjtxgh@wfg-t540p.sh.intel.com>
 <20180418134058.l3orjjxcpv7cxjfw@wfg-t540p.sh.intel.com>
 <CA+55aFz=VCq6w=kH5aYavOM0-h130HgzVhVc94JxeYSdbMWbxg@mail.gmail.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <b66f6034-7631-7fbf-56aa-e8e136e8b636@virtuozzo.com>
Date: Thu, 19 Apr 2018 16:35:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFz=VCq6w=kH5aYavOM0-h130HgzVhVc94JxeYSdbMWbxg@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR02CA0111.eurprd02.prod.outlook.com
 (2603:10a6:7:29::40) To AM6PR08MB3256.eurprd08.prod.outlook.com
 (2603:10a6:209:47::21)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR08MB3256;
X-Microsoft-Exchange-Diagnostics: 1; AM6PR08MB3256;
 3:FAWeqydJO1iD1BKOTH604qxKLKQ2BDVQsw58rAtmeld1pPBcA2uHwxB+OD72nzeOjXvzwnQCoCtGDHFGStY4Fs04dT7Xmtc9CfzaZqc6gKXLPEwq7Le0u7SF563YI518Ij5Wn/fBGTV81hX/LbokjSGmNJRvcSV1FR1pH5iCONOOHIQMbL/O0i0Nxr87Nl0dNVrNsj3y8IpYJitS4ACJCt63j6+qAdPVY0euavcXERiBsKnTnYmByFa9Tz3UtQ+0;
 25:wiyO5L6x7IwA2JcrxF0k2vsIn67JEpaKAC53DW7KyBTFPchQS+6A+y6/uRifQrfnI/P4cUjMeJ/JogHYZGCBYVaUXgzlwyWhwhV4fABUcdVugCj704zdb9zAq/RvPZKdCfgJtpQPOYcKVHd6/eVspefJB8usnnSlhIR6ne0G8tHdHhbSPg1oOsNbDt4ConZg0WTXFiF9i2ZI8LT1tnFczq5AdD6xhQtYaal5lQGhsIxRk5kbmM5mUgREZiVFD4bTvHc3+1TLCruea+/hQc5wqQ9anJljHnJ9CYdV7uBIRPdmqriWhKHJnPeov+QY2VzZpxTYvdw/OVYskFIzQFcIoA==;
 31:UZnOxnQSmrJ6rr2hd2FJp/Ll9SWoJR/+UWvruXsnl8wtczSrWv+1aM19JQjx2k91LntvUAqyW3y53mPTlYlW/5fji58E6K3d1Ee++JiA4XZ1IY5tAcXcPEHyZVqTrqnhzcniVF5520/UByVq+KqECplldoGgR/GHftY5ShHuB+cmnp82uMBaXnxgd3yB6GTicVWlAr7Ok7T0y8lsl4Fgw1pnrvdN6yH5baaec94jcls=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3256:
X-Microsoft-Exchange-Diagnostics: 1; AM6PR08MB3256;
 20:U+sRpUuqbYAf+GziR5b56GaZF87PyWw/MMtgj6/iMmUnLS9Kvi0udahbvgIiivTNAuTeKb9fu03CAuewMbdq4KPTFF3Qie3klNA032gAszqm/AybFGF9TUXfLCrBz1IkHn6UZOgxkiiDLUHpY9vO2j9RDrxbhM9yFEQ1y04WI0pxTqYiUdHaXlyejiiUwRaUqSGCQxe4rqmtxnjidAfm34w1KwY/I6ip9Yj9RqwNEGH4jLvOZxizO2kJrAh1NBb86s58eDRop+dD5coJGjwTWoabq7REjqYI+stazoK/lvqkfa0IBiSpuLL49eHFKzWdqbDrPgk+KpBIH1TijgmiIoP/EluOC33MTpYC67qqDI3u0LZ/XhPHBhzkAA7mBtwH0yxolF9csICz2oVdBt1CcIsf2/6LIjrrBZLSM/gIfQcNGV3FGDbQzmKutIxU3aIX8mvAF9QdzJNN0EP+KTDnUClBZk+HFx2FYKC1k074aoXzV1FzhsT89Qqpf8tKhihV;
 4:EUNlMqDCUcUN4q0mmoxq/xxz39lgnvml31bTHaOIwHPWZBVKjrmkg2Dw+hSVRe88/hpbPA2+FMEQ5y7RRL4C1Ho1yW4v2PNMrMWQG5pezImQnqKD5UQMuYGHTJEwKcJ48UZ7u/wF8W8mrwOZvCy0lNeLDZZgY9xm04pq85MlXUzdxb6t5sEgLstnqKFiHR+KF1KEst4nPi5WuSI6S0M8YYoKH7MKAlMjw0e/InBfhYjDYYJfHo15O13AxujZVPAgscAN+uX+VwQdICydA4QREep28JCgTBFWmxRbeC2IUxlrPJlUbjIDOUPdde/igRXb
X-Microsoft-Antispam-PRVS: <AM6PR08MB3256234218AEE458E023BE3FB0B50@AM6PR08MB3256.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(42068640409301);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231232)(944501383)(52105095)(3002001)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);
 SRVR:AM6PR08MB3256; BCL:0; PCL:0; RULEID:; SRVR:AM6PR08MB3256;
X-Forefront-PRVS: 0647963F84
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(39380400002)(366004)(39850400004)(396003)(346002)(376002)(52314003)(6116002)(3846002)(76176011)(77096007)(31696002)(6306002)(16576012)(25786009)(53936002)(316002)(26005)(11346002)(7416002)(305945005)(4326008)(956004)(6246003)(446003)(52116002)(2486003)(81166006)(229853002)(2906002)(8936002)(230700001)(36756003)(52146003)(7736002)(8676002)(86362001)(23676004)(47776003)(66066001)(50466002)(59450400001)(53546011)(478600001)(6486002)(386003)(55236004)(16526019)(186003)(5660300001)(2616005)(476003)(65826007)(54906003)(110136005)(31686004)(966005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3256; H:[172.16.25.12]; FPR:; SPF:None;
 LANG:en; MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjA4TUIzMjU2OzIzOitzNGRDTlFvdVFFOWNVa1B1bTZZL0lpSUhX?=
 =?utf-8?B?L1J4bkJXM2FKZU0rdkpMMmNBOU5wdXpNaWRKS2lNM3VLc2RQL0F0WnY0TElM?=
 =?utf-8?B?U090VXpnT2xTMVJpZ01PSzJzb2tQSi9TeE9CR01NbmIzcVNUa3p6VlFyQ0JD?=
 =?utf-8?B?QU1pOFVON1lUSVI3eTNqN2I4dXY5eWVoMmFSWVVRbFM1NVAzbkZYV1g0SFlU?=
 =?utf-8?B?NU01bjQ1MzJFM0Zhb0tMaGlQQlkzcndJYlZYM280cjdxbnpLNml0dldEamhF?=
 =?utf-8?B?VWZvMGREYTgvVlVucVh2T1l4c3doUnZzUzQ4bWxHVmZqU2tHS1RtMEJVOTVl?=
 =?utf-8?B?TVNDMGlNQkI4Zkd5U2JFa0pkTVI4UVhSKy9vUWdXcGhUaGQrMU9pSWVxaXJ3?=
 =?utf-8?B?R0JtY1hJa0Vhck03SG91NEdrK3lWdEhDNWVncFdhaGs2cWI5QkpRTk5IVHMv?=
 =?utf-8?B?UUUzanRzT3JmQ0dNc3VQSFM5dFR2RSt5WUIrQk9ycmdzc01JU1hVL3RkNUFz?=
 =?utf-8?B?aDBqZDVDcVAvYmpiL3dlSFo1MndWOTVocWVsdkt4WHFNWGJYZS9OcVhVREli?=
 =?utf-8?B?RUEyYTI4NUVVK0pqQ2JkNUR4ai9MelRqYytqcEoya3h6aTlkTG9DYlVCazNG?=
 =?utf-8?B?ZmxyWEwwOFlDYXY2WDNMbkIyWWdIam1Rajk5Z3JmTjlpMW5MMWZaMkFOUnVX?=
 =?utf-8?B?aEVzK2hLcXBlRmVodGdJS2JORUJwZTZ6S3JlNkhLTUNvZEdzaVJEWE8xeXNC?=
 =?utf-8?B?UzlsZkw3VE5aTVR2aWNrMnk1TUoxZnFYWlhYOG9iZDNGYzZDOGFZZmRHblM1?=
 =?utf-8?B?N2NWVUFoaXlDYmRqSGpsdGdIdEZXdFpYek0yZ3pNQXZtdmtDcnkyeDhWTjBU?=
 =?utf-8?B?bnhYQUFjeE5rSUVqeWs1N0hTakc4bmVDQzZHUklDOFlOQzVhRVlCVDdnS2hy?=
 =?utf-8?B?aGFXa3ZyTFRmYmZFQ3ZYam1ZTlAzNHE3SURUOGtHdmRPMGdJNlZKY3Z0aktx?=
 =?utf-8?B?bVlJYlhudmNpMDBHT0ZJS0NoekxLNzNKRytVekN4eDZjdFFxb0R3WW5wbnpz?=
 =?utf-8?B?TnBhWWdlRVNzc3RDbDh4UDVRODNVbm9MQVlBUlJnYVJvcG9rYkJ1NmMxR0Rs?=
 =?utf-8?B?MFZyanZHZDJtdkd3emM1MGpQcFdtSXBuWEh4S3lKbnpGaklXdlVpVG96a3lk?=
 =?utf-8?B?am1GV3R5VDZwbG9TRzdTNVZMR1ZuYXNxeTBKaE9oaTQ0d0xOaStubjMyYVBv?=
 =?utf-8?B?dUh5S0Y2c29Fa1VPT2JSdGpDbGpJbkRKS1crQU42KzgybElNbEVtV1gvVmtW?=
 =?utf-8?B?bENkT085Vy8vY2RSYUg4WW5oVmVpT1o0RHFObjlVcWd0Z2ozQ0lnNmp6Kzlj?=
 =?utf-8?B?VWRoSWlnViticFFmK3dGdUFZaDdhc2hIcVJTSWp2QUZkQ3dGSFk4UTNtRUxZ?=
 =?utf-8?B?M3NvNlBrWTFmVXNUeHMwcU05MTdiZE9xYU8xdVpxVDVYZHQyK3dkZXBnUjZI?=
 =?utf-8?B?Q0ZxUlN4Z1V2dmlpWUpXTXNEY3FteXFCMndqdWxwNFVDSUdCU016WFVWYlFh?=
 =?utf-8?B?T002dndiNzFodmRMeGhTbkhvZG14OXMyYkdkSFcvcjQ4dDFHQnVjUzJrallS?=
 =?utf-8?B?RStycjVPNk51aVdTOS9aVEYwWHFPSE8ySU9ZbFp2NjY4VHdMYWVOam5meTZC?=
 =?utf-8?Q?qcC5mm6c9E37M+uoWVBr1pyPZyur6WUD9H3nloi?=
X-Microsoft-Antispam-Message-Info: CGrrvl378Q/6eKG7NKtvAnj/tdfuwYv5RaZEzQSpFWUOKpXBABHZv4C45n1g2k+h3kDG5CXfTq3bpZi0CZNcSe0pv8b/WCqNz7+YHTLNYy1cyGJA7XhDno0yW+qRdpBbgXn1G9b5z/6i+N2Q8XfEy92BLAaxkE9OsIqubxJ7B7YCbc6dI7NE7A0eI9eNCgUi
X-Microsoft-Exchange-Diagnostics: 1; AM6PR08MB3256;
 6:SMsK59RTwWrSlD9rsttsudX4nYoxgcmU4hCDKVZZuR+notRFgBo7QSW/ncJCvf019H5Fi7cv1itNhZZ2/dyDS3UwhmijFdvJvULvsxDbE8FHAk3M6zR7S6FxBd0DSm5i5JLRDsXmkCqh6CCKoT7ZjbKjf0doDTwUUtLo60O6YEGMw/LC9qIMk3y/gZgcdbsXInZHhCZcfvu3WuvFyoeRU/hzUGc2G+AU0Xku2OUaN1qt7qAkRQdmfjvsR9DE5aczu2xhhhPMhTuqfy8x6N9/gSb05MnrSCxopbeKbBmMsg4A8g3v3C7BDsapk1Vg6g6JPCTcSIIjnA9sYSdxbVuVrBL+hV+BAKl0o4wP4dnVVPePI9lcWILF4C2pt/w4v0uCNB1MzKsM6H/SQqtqw8Zc9RImjNcIdTwmwUl+0zCLX/vNSByx//pFKmokgzgR1cfZqqUd2Bb4CxDeyeDwFfHVYg==;
 5:TNJ9nESt2GC8vJ8aUeNoSqvr4Eso5adtJRx+T0P+yeSOjZ1WlhJWXEQ5/DsGgm5P2GpA8rLXBxrYu3Kw6gvtZd7OjOJbRD0E5jzvUIKNRhCLVmSZ0XMCeQk0BH2jdKqFfCx0W4K4kMY96r1xysq4yAQjrbHpCj/54XTWdjUKxzY=;
 24:WOQePl7VwQfVimwPkx7c5Fi9XoljHHnsU7PEniKbiX7EEd18AOPnk/O0LTOuYeHdsAMqCQs7Uafc7e1Ktmrv4G8sQyoiqb8OXKt7ywVDsK8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1; AM6PR08MB3256;
 7:Y0L0oV+e47hIqT9PTs708rKSdjKPbaIYsJQqydKISeMvkwkxYUEVvYavwyk1hXPnRMqicqcAoddYO61aDcK/2jNe0yBQ++eHXkI1I720LCVhhZp6reN8TY5R75BFZVvyxlwK9++j9h9jPyV6eqhqW9C1l1GH9dj6QZGTdS0bppuTraCYn3TF9FhktxZDkdonb7QcojVMn0Zqiz8CXxpiIcpbHQWAHvikKaBD/lIcvKLaa2jSFaDuIiV7Ch18DMBQ;
 20:7pbnIqaJ/uKKzlyJse/SMy9o3OYiOdxAi7Cy9f/npnv7OM0zQ8dukm0+3SqMfCftTvG5PTZuyrYf8V6cC1JPwki+7gTWcnKVsdDhfbi6k4VEXhcKsVw5P2+vduiUS9/Gj8S2YZaTXeh1HLLikMWo4YsvWqUO/PvCTzGp0a0wSUs=
X-MS-Office365-Filtering-Correlation-Id: 8aa27e66-2e7d-405f-ec76-08d5a5fa3c5e
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2018 13:34:10.7772 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa27e66-2e7d-405f-ec76-08d5a5fa3c5e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3256
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: Staging subsystem List <devel@driverdev.osuosl.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Oleg Drokin <oleg.drokin@intel.com>,
 Denis Petrovic <denis.petrovic@edu.ece.fr>, LKP <lkp@01.org>,
 Andreas Dilger <andreas.dilger@intel.com>, lustre-devel@lists.lustre.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 04/18/2018 09:37 PM, Linus Torvalds wrote:
> Ugh, that lustre code is disgusting.
> 
> I thought we were getting rid of it.
> 
> Anyway, I started looking at why the stack trace is such an incredible
> mess, with lots of stale entries.
> 
> The reason (well, _one_ reason) seems to be "ksocknal_startup". It has
> a 500-byte stack frame for some incomprehensible reason. I assume due
> to excessive inlining, because the function itself doesn't seem to be
> that bad.
> 
> Similarly, LNetNIInit has a 300-byte stack frame. So it gets pretty deep.
> 
> I'm getting the feeling that KASAN is making things worse because
> probably it's disabling all the sane stack frame stuff (ie no merging
> of stack slot entries, perhaps?).
>

AFAIR no merging of stack slots policy enabled only if -fsanitize-address-use-after-scope 
is on (which is CONFIG_KASAN_EXTRA). This feature does cause sometimes significant stack bloat,
but hasn't been proven to be very useful, so I wouldn't mind disabling it completely.

So far I know only about a single BUG - https://lkml.kernel.org/r/<151238865557.4852.10258661301122491354@mail.alporthouse.com>
it has found.
There are also a lot of other 


> Without KASAN (but also without a lot of other things, so I might be
> blaming KASAN incorrectly), the stack usage of ksocknal_startup() is
> just under 100 bytes, so if it is KASAN, it's really a big difference.
>

Yes, it's because of KASAN:
CONFIG_KASAN=n
socklnd.c:2795:1:ksocknal_startup       144     static

CONFIG_KASAN=y
CONFIG_KASAN_OUTLINE=y
CONFIG_KASAN_EXTRA=n
socklnd.c:2795:1:ksocknal_startup       552     static

CONFIG_KASAN=y
CONFIG_KASAN_OUTLINE=y
CONFIG_KASAN_EXTRA=y
socklnd.c:2795:1:ksocknal_startup       624     static

It's expected that KASAN may cause sometimes significant stack usage growth.
This is needed to catch out-of-bounds accesses to stack data.
When compiler can't proof that access to stack variable is valid (e.g. reference to
stack variable passed to some external function), it will create redzones around such
stack variable.

E.g. ksocknal_enumerate_interfaces() which is called only from ksocknal_startup(), thus probably
inlined into ksocknal_startup() does this:


	for (i = j = 0; i < n; i++) {
		int up;
		__u32 ip;
		__u32 mask;

		if (!strcmp(names[i], "lo")) /* skip the loopback IF */
			continue;

		rc = lnet_ipif_query(names[i], &up, &ip, &mask);


With KASAN stack might look something like this:
  [32-byte left redzone of the stack frame] [up (4 bytes)] [28-bytes redzone][ip (4 bytes)] [28-bytes redzone][mask (4 bytes)] [28-bytes redzone][32-byte right redzone of the stack frame]

GCC always use 32-bytes redzones. AFAIK clang is more smart about this, it has adaptive redzone policy - smaller redzones for small variables, and bigger for big.

In this particular case, the best way to reduce stack usage is to refactor the code.
1) Drop 'int *up' argument from lnet_ipif_query(). When interface is down lnet_ipif_query() sets up to zero and doesn't return error.
   But all callers treat up == 0 as error. So instead, lnet_ipif_query() should simply return error code, and 'up' won't be needed.
    This will simplify the code, and should drop the stack usage with KASAN and without KASAN.

2) Instead of using local ip, mask variables, pass pointers '&net->ksnn_interfaces[j].ksni_ipaddr', '&net->ksnn_interfaces[j].ksni_netmask'.
    As in 1) this should alst drop the stack usage both with KASAN and without KASAN




_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
