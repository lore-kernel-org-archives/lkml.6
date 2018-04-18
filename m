Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AIpwx4/YhyX01AHZfAEdXn6LYsvQZdGvf5A2dzImRTMy41ddBHO+7OGE0Q4fsidUwa8aHQZu+hqh
ARC-Seal: i=1; a=rsa-sha256; t=1524056769; cv=none;
        d=google.com; s=arc-20160816;
        b=KLrDI3crL7Glfr8r67BJpgaIYT7+UUHIj92QOR1ou1eMopqU5ZCSVOc4huVw1D8J6Q
         /pkAaMyoJkJSEEDuKECk+JLfiMW+19QIjQyRjoNY88lKToWt731rTy1MUXkuNYRlj+1Q
         dPwlkGWZ8AcgW6mCrnGMVuCnzsz+QHsgfsUuiWTaJYhQ1qAYPmQAv+T8cGgO12ccTc4+
         02ki3WIYvSdCCpcKNHSu7oDZDRY691N3cmZqYquj+Do6at5pEt/QtE/+/ehqk/JRnUBZ
         PMiRc0IHeUp3sM5WQzb3XoBZ7+V+gUXRgBlEHBv5Ejtj7Dfg997ujeoYBCsf7iFLRCeU
         zzlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=+GAsYbg239qGSkQRjOOaSkAj9B5y1lmwayWLfc50igU=;
        b=bnW7nm+gaU5PCbXtNWZMufUzfu1LN9yi1/VDJkIMTMcl/3eUxdu9B+dhdR/anITI/o
         vXHop2lp5rxK4xxAqNKORQMchzK32VsFFmTcP0rNhpSOcjZuXs3M+W6ZsHKdnyPHqxh7
         4g2Zd07ufPmIxkOVoTnIXKEGMN9xgpO7mxG/MNgl2+xkbDPGWAXopCtvsCkuKd1tJRok
         Np63PkGHVWN8KuUqHW87BlBvb/SDDzblnurDsvc98pF3Wix2s+ofXgeQc88ctfYm0/Vf
         04N6deTOMrr3w/rhqZN9+Jrdjg3KvDAw7PglipARExFUMFbI5HVtsqAfXnc3QgtbGDTL
         eKuw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=DHKll4ro;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.100 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=DHKll4ro;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.100 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Subject: Re: [PATCH v2 04/12] mm: Assign memcg-aware shrinkers bitmap to memcg
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, akpm@linux-foundation.org, vdavydov.dev@gmail.com,
 shakeelb@google.com, viro@zeniv.linux.org.uk, hannes@cmpxchg.org,
 mhocko@kernel.org, tglx@linutronix.de, pombredanne@nexb.com,
 stummala@codeaurora.org, gregkh@linuxfoundation.org, sfr@canb.auug.org.au,
 guro@fb.com, mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
 chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
 hillf.zj@alibaba-inc.com, ying.huang@intel.com, mgorman@techsingularity.net,
 jbacik@fb.com, linux@roeck-us.net, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, willy@infradead.org, lirongqing@baidu.com,
 aryabinin@virtuozzo.com
References: <152399121146.3456.5459546288565589098.stgit@localhost.localdomain>
 <201804182053.71Pa9aRK%fengguang.wu@intel.com>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <9d2603ed-e7b9-3eb4-2e2c-9ce2060ff853@virtuozzo.com>
Date: Wed, 18 Apr 2018 16:05:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <201804182053.71Pa9aRK%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0101CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::26) To AM5PR0801MB1332.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::10)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1332;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;3:W3WgCsGivOkfFHdPTxuVMIZFD07QuChieNP/Glwi6G8BTTp9dHok09YA13TV1kEZHKC/H+6yOIrHDPAxm2oNWpz5AXjYc9qWRAVrVAjgGBbYLkuJDEz0MbgIaRK2FwiSyWHshLbWfTJyWl/xn49XOmPmR7dOCFaqrGK74ya4ibYdRkT/wdbpfvX8YKwBrad4PQHNwq2Sxg/Sg0ynC4FRngVsmqTrHO6WdJlA71T+01uPtV7J87jh27KvHmnCPRvJ;25:/CZfYsVMkoCZeAfEVab60TDtjMZVmw2aS2kS/cZ7KcpGgN71hhnIyp4e5CxGnl27OyrzqGJPu+YcvmPx71vW+kb2Zb2gHF3QZ7fW/aQG4DMBF95rRRas6iBCXdFKK8Ov1mG+kQMsHheYl0Yi96S7HZoQg6YD3WzKehwPVhsMe0NXi7lsdda2cMaQ19yDDrIdFC35Elbu5R/3lvz4QLosdb6su1ULWP/eEKTFkhN76nDhX8Lfo2bz7avhgfGgPXjpAMUyscbTXGqJwhsTvf4yS+jY+X1k7xhFw/fFmmmDNzNDlsulhD/O97kVn5Tfl7PO/zfiKddimmorTa3Ywd94IA==;31:oRxtF3cT9O4hXIyPrJXar6Um2MWKyOD4HmSp1mo9VIqCy+fLyI2fRDqmIao1F3jtnqU1q5KeJ5/KW7Z7WnD3xc05sWlha0wnS9k1DdoYGnHUs8oGtsbwa427qKOI0xURWho1egS5vkpiK4vc9SyNZ6gId7x3Dy7/OAFEqXXicYPiriBObPJRZy2bSSnwXOInE0jOsJ4uhG39NNh8kzVQUE7CduuZbsU5obgseZ3ICEs=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1332:
Authentication-Results: outbound.protection.outlook.com; spf=skipped
 (originating message); dkim=none (message not signed) header.d=none;
 dmarc=none action=none header.from=virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;20:Cvj/ZdH6Xek8FB+w9DQGSlvL6B1rPcZKF2fhKoFN+q0DjLe7uMQhTWPxupD9PXNmy3QzVGMh3M3rbvv5/zoTeoXDA7CqlGRpPZG3Vf2eNzy5DTC0Ic6Nbeh1dX+YeB5AkCYUs9B5mhUcmbFDv/Cb7IESmKYxyxGts6FcXFz/VhLvSzS3fX6V8MSpKnYS6G9PqQLKXia+PcG50XgbxRIqAGmlyp8E5vGvzZ7uL/Q+Rja7Qa2/XTkFMheyHZEhT31eg8B+hxBsAAPMvJPOaNOcprOOnilMEOlpmMG6VVbZRTJlfniNaAzmtwzK6RsTHkELimr5gwbRDaYRX0e+WgA97PySnSXmIFBni2WLhvu2xvAikKFKVW0uMLtlOFJk2vnuOeZ3/QKECf9PlIGQLncqgMPjOzjUMAblt2qEZBaGvqiLyZXcDImhFKGYyGMJNMkyRppIT9zncMYmvKR2awammkCVUJGp0fgdk38PuYksw3lREUVjeDbRogj2DqiyrT5Y
X-Microsoft-Antispam-PRVS: <AM5PR0801MB13325FB2EF5D43AE4B308417CDB60@AM5PR0801MB1332.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(22074186197030)(166708455590820)(183786458502308)(162533806227266)(211171220733660);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231232)(944501368)(52105095)(3002001)(10201501046)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:AM5PR0801MB1332;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1332;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;4:Im88YMOwc23EuYJIbyyPOcl95jvMuIpoUJop9MPhLvx9BIaXP5bOIilX7eKw1oKSwOfWP+Wq/CNIdVIYNqXaOmlhYsjDDfJZ9e7PMxbGn52u8yXkBSEVWOeM7aVn3xGxZTAHT1OSGIp5Z4HUA/TZXmnlDluFbndEu/OxsyoNCz2n5w6nHO+/P3CP/TC2e25Y6fQIYaEzdk8Zsd6Cm3icgB/lJ4HKt99d9+ysYPMjNIq+eG4j5AklZgOuACdbCXEhLDIIfh8E1r8wzYvaixCllBPmbvMTXQ3WNtJN2oCI6ilGJg7yi4kZ9i8ZU/jqv5gF48/1Poa4cHNCAbL6UYc0bpwDZZibQ+iDCX+pVivcePFyX3Rbqot9rU3Yh5P2Y9V6K17AeAPe979GFl9ld8eb6OLyn+d5VGYj6FRFJgEm58lkm8zymPC7HQQHatTMBBpQ0SUocAJ/o6V6reLqWmSAYQ==
X-Forefront-PRVS: 06469BCC91
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(376002)(396003)(39850400004)(39380400002)(366004)(25786009)(230700001)(23746002)(478600001)(31686004)(966005)(6916009)(106356001)(6666003)(305945005)(6486002)(229853002)(7736002)(19625735003)(65826007)(1720100001)(5660300001)(7416002)(50466002)(68736007)(53936002)(345774005)(81166006)(47776003)(956004)(4326008)(11346002)(5890100001)(58126008)(2616005)(8676002)(6306002)(476003)(16576012)(66066001)(65956001)(52116002)(16526019)(3846002)(6246003)(64126003)(316002)(386003)(36756003)(59450400001)(107886003)(76176011)(26005)(39060400002)(86362001)(31696002)(77096007)(2906002)(446003)(6116002)(65806001)(8936002)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1332;H:[172.16.25.5];FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;AM5PR0801MB1332;23:vNhhAa1IojZtZP423aLpLOzDnh7EGUJVGEZ?=
 =?Windows-1252?Q?Ofqc6+sHfe2Sew400Z0hmfEovrUOV2aLYnUvX+lPlPuHSyyF2Wh9UnYC?=
 =?Windows-1252?Q?6uLYknsKuZ7039gBLVC5dxfPN2TL4CufDzARWcilOdOzmubus8kox3Wo?=
 =?Windows-1252?Q?eTS+1xgFSanxJ6IYJsou56h5g8GArPMj3JPa3BGApANwlqrj7JRpfm6T?=
 =?Windows-1252?Q?KH07PvF3Mxov3eJXk/hKoW6w44PLe8jfnB4hbXG7rprOtw4l2YjGzClL?=
 =?Windows-1252?Q?hA2H5CxCfntb7W4YD5dhrWXHMwDS7A+lDiEThSqGM+i7rXS0r+BDc3Zn?=
 =?Windows-1252?Q?YCWcGoHiPImoQW5bAsUfxdD39eT+hBHMDmx7XQ/lOTHPcBHrCmyhVySv?=
 =?Windows-1252?Q?k6+mwsBABwFRXNiDMdtZZa44JjjsJlgBnm4w2IU2l3KOE0JCUIcngtG/?=
 =?Windows-1252?Q?IPh4uxbiwZWPWGk4oY96pQblftH7Z3pB4YWzs+8AQFq/+n81juq1foMT?=
 =?Windows-1252?Q?GlkRnwmiGn/YzFpgz+nmTHn6JsGOTT1W1p/bImX+ZVLO0zd1Vv86JtK7?=
 =?Windows-1252?Q?4etHmCYaNVw85xsXvnWe6Sz4HACfDZ9PE3vG3L5cYCwNUmqMWvCBADxC?=
 =?Windows-1252?Q?d+2AEoL2Wym1ZE5keVsgg1rXOpy9EmEMU6a6LgKRxOkMdscTbujbavJ7?=
 =?Windows-1252?Q?NUzzq3x1DRp3VOBUpYnusluUxfVJzkThFsPzMmz7SauMLNucIU2jqePY?=
 =?Windows-1252?Q?gu/pGMKOsR4/0sCknu7AsgYOQqtUkErzSY8XaINu9Ks/hEpEdV8UHQXx?=
 =?Windows-1252?Q?/9uB+b6mkn45/Cvd+uKlYn3tBMl+Jn7fFpzt4L1HBhUYkZaHg/hxqD7C?=
 =?Windows-1252?Q?82KAxhOpT1QzdRFXUcO6hS0uGehHBVro1UiRxk3Te7SfmlTsFjYn4HiW?=
 =?Windows-1252?Q?a+y36VCkKu+NmWfNBMv4RxkTiPnBBuG62mAFMRM9Z1vaDDBaskBriRXM?=
 =?Windows-1252?Q?Wy9TdkuRl4JMHICFtqOSZDxggI7ehejpJlqURX5ogZf2xp2Q0OqPzah9?=
 =?Windows-1252?Q?M6d4VJmUd4X2KDNoJPdpvrCc0UOLH8/VJ6bJtYAWhXDuJbhc7Nua4mHn?=
 =?Windows-1252?Q?aGoY9Xw+cFCbmhjD2UKC/wLyVxcs5SqJ+gs5R7Zv/eNnc7kxdzwVuHfk?=
 =?Windows-1252?Q?szH9EA7oV3sN3swiu0ULC/IQHNDeP+adKF4ymucFpJvvxllwgWXlphMH?=
 =?Windows-1252?Q?R4Fb5H9vyfXzVC6HCh6v8P9qi0DR+a30bect4t/fRMgDNetARt4N/dRt?=
 =?Windows-1252?Q?E9RBO3OjwLPY378y08LHXLiWTKvmGK4MkWgjEeS0mngFE8memEmZAlyW?=
 =?Windows-1252?Q?PDPEHHwxdPxZcr22pRQmjvpNRVa49A258UZ+f0sSeFI4MBmSRXcUuMiN?=
 =?Windows-1252?Q?fymbYuAEcKmU2xFbas6OHarbLpMFf9YwmT9oaCUUlBNxym12mf2XImP0?=
 =?Windows-1252?Q?nCt/l9cUE/zF87nVGK8lJepQ+oPtk9/tYgLyulHAvmMhy1un2lMX0ZgH?=
 =?Windows-1252?Q?zmq1ci68/vh0d2c808QPOA46DAaBgJQFzsgFw?=
X-Microsoft-Antispam-Message-Info: ZshQqtEpkZax/tQi/kzMo0AvuMiYkJ3TkN82ibiPb9GBfel4KbkUtfmk4ziKwIJphNceIt7wUy1hqeRAx1zjOycD0RLTYJTG8Nw2B8rwZ6CeDsMCBECAGX8mGKU0ICv8sJuXPg6Xg9WF49N48s1l5I4H5bUIcEn4KiGB6MedyEFY8GD5ip3CnrOkY6eSd/4R
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;6:NIVMRKGLtDjqkywZvSgXaakGDt8tD5+RRimRY4SoCk0uy+zFA09zAmrSSYxv1UVVBixFYqq18a6OcJJAutyGrcpq6hW2SFvYMflf0z+8cJ7SeC9roYSFUDFUJmlAnaV9zieHnQmKMq8vNeXu5eZ849qiBtuJhQsO2x7/Z/yV5JNTp3miT63HywB+pMl2bDGXivTraozLI52XzYfNSXEyFcllGYrp3PzghpmrllsSd250gCp0gWKn9nSrOtkYF+Q0MLhNAyRtV4QK18509gbvyq+kRUG92ciX2RIqFzcnEHie8dHgdpEFlFvzc9tmSYfZY5Q9u8GjnJqxFuNwn5qkt9kF0og1c6Cp5PrZ8m77l2Ogvhxw03evKzNdI1ZLzzCoRwpk9YzzpbxbCdoyMv5AuN10gLTXapbMRO6B937qgC2rFgT6Syc6E1nEO/Dw4wUZK8BaPcWHXsNBtu3XPKGdIw==;5:mWY+ITjEaGWc6C9Vq/q25nrgEtxPlJsdGRy+ZP226n4lXdunzvPOcH1Ocxk8/3kbST2pwzGOgoSjeCsJZmto9YlqCyAE8uASPrKGbSb4xWPV/y6m5uFFjgtMmbMO3BXUwXgNNYgRdgOYcjJRcAQ8HM9M3tvlDF46aJaVdyszeLo=;24:MBEDMn/d+mJq9pSKjZsIyCRR9WTNqfGDgZ6hvUZrQqAAqAS0Z/ZeHkhlDrBwpB03c6SYS7Wo0qTDco/VFAdX3WCin+O3nlUR5lqR3bRaHoQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;7:bNil1DXG3r2lCYCGluaenOrJ0bwUTs3TkPZZcsaeIfsQCz2LUlacy0QvtHii2jnrtjEPjGa6u5BWvts/PCI1pITOyLbFt1qksYPE4oDFpUV4pVZKlirfRfUqSjG2rgc9quS8pP4W30PUQRIAA4IE4JPjIYE+DG6C4Joa4KFWAV14Iv7eXYdzDTvlawTHAcJ/nWmfcZRkvCj62QSDisggeNqHD1SbGcPKCdKb7FlrZOU4FMek9TeBbvqNubMJoGUQ;20:TrKLrWVmXa1FgHwQ8T+DPbbc9F4Nu9SmCjoKzPX5tWSrD+qswg3CFCYVIESUO4nYvQsqac12r3VfEhljLN9+6Pg28P4Sw+MKczX3TxBtsu4PhSlWgbrP83MpvCzwR+2WGFtd6i0psPFdcyQqJrvv9wTmt8ljJKwfDoZ1KdIl6hE=
X-MS-Office365-Filtering-Correlation-Id: 8e0b5342-5bdb-4ac1-4fed-08d5a52d243a
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2018 13:06:02.4619 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e0b5342-5bdb-4ac1-4fed-08d5a52d243a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1332
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598009310068873507?=
X-GMAIL-MSGID: =?utf-8?q?1598089351228681811?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 18.04.2018 15:55, kbuild test robot wrote:
> Hi Kirill,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on mmotm/master]
> [also build test WARNING on next-20180418]
> [cannot apply to v4.17-rc1]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Kirill-Tkhai/Improve-shrink_slab-scalability-old-complexity-was-O-n-2-new-is-O-n/20180418-184501
> base:   git://git.cmpxchg.org/linux-mmotm.git master
> config: x86_64-randconfig-x011-201815 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
> http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings
> 
> All warnings (new ones prefixed by >>):
> 
>    mm/memcontrol.c: In function 'expand_shrinker_maps':
>>> mm/memcontrol.c:402:9: warning: 'ret' may be used uninitialized in this function [-Wmaybe-uninitialized]
>      return ret;>             ^~~

thanks for reporting this. Actually in terms of kernel it's a false positive
(since this function is called at time, when for_each_node() iterates not empty
list), but of course, I'll add ret initialization to silence the compiler.

This should not prevent the review of the patchset, so I'm waiting for people's
comments about it before resending v3.

> 
> vim +/ret +402 mm/memcontrol.c
> 
>    377	
>    378	int expand_shrinker_maps(int old_nr, int nr)
>    379	{
>    380		int id, size, old_size, node, ret;
>    381		struct mem_cgroup *memcg;
>    382	
>    383		old_size = old_nr / BITS_PER_BYTE;
>    384		size = nr / BITS_PER_BYTE;
>    385	
>    386		down_write(&shrinkers_max_nr_rwsem);
>    387		for_each_node(node) {
>    388			idr_for_each_entry(&mem_cgroup_idr, memcg, id) {
>    389				if (id == 1)
>    390					memcg = NULL;
>    391				ret = memcg_expand_maps(memcg, node, size, old_size);
>    392				if (ret)
>    393					goto unlock;
>    394			}
>    395	
>    396			/* root_mem_cgroup is not initialized yet */
>    397			if (id == 0)
>    398				ret = memcg_expand_maps(NULL, node, size, old_size);
>    399		}
>    400	unlock:
>    401		up_write(&shrinkers_max_nr_rwsem);
>  > 402		return ret;
>    403	}
>    404	#else /* CONFIG_SLOB */
>    405	static void get_shrinkers_max_nr(void) { }
>    406	static void put_shrinkers_max_nr(void) { }
>    407	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

Kirill
