Return-Path: <aryabinin@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZqU2LYsSLupmfFyWOTeyqlF9d5XsGE4ASEm64LaM8fzjynM2lqPWRNnOm2jGqPI+HqsRvkT
ARC-Seal: i=1; a=rsa-sha256; t=1526389947; cv=none;
        d=google.com; s=arc-20160816;
        b=qx692it0ZWMo2kRHlkfXE+1reDPKlon2rpoaY9NZd8Gm+F6Dlad7mT8dfQEedUcTR2
         PEar2eeLItfg8GM7FMXdYMeCaVznLMmQvwUI7P/KEjQd7BA9kQa31H5W1DaUSgR1cgyc
         vWLvXnJ8e8gk5IRJwBm6IcQYPeap6H/Z1Jzg6u9yDSra3DUEkLEmmiKsUCAmDpK3D35c
         MbqP2/mgTWCLjoP/OyPWApjVhHBdcB4phxzg63NnDvJNZh2+PF8yIdVSHMJkfR2Bb22I
         637mtWNdZAheg+0JxhnHee4jpI+LX5K2qHj1Sc/k1/RP/JxjAOEib3RijK6PX3bNhfD1
         4zWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=w8vsCR+yGY2QlNMfOYYacAhxNwud69aPyk9eHulqZPU=;
        b=Bn7I/48Es4CeFXOHgZq07WsWnd28a4W6tLKVD36HGShaEbsbnTUst8h20mESwvVBmW
         Qg4/Wx7Xmutna4KU1qG5VYN8LCJa7ejZJuKOQkyKcU6fQ9wsfecYC/gCht3rG8oF9cdd
         r5PTsqS2NHiqxQ4F2b+ccIL4UvgsYLL07lueLaSvEl5zqXbz4FK6tF2wme0dJKZ+Cngt
         qBf6X3ECdEUm3vrX7jIHaGk9duXHWAazeabW1NaozpbhNIlL5dMPrw/t8iAovMglh5O2
         HItYEdJ6yQ0GFo1angF8pcsBz7aRqGKLJjVMaYNAOqX+C3LHD4W3w9DfhMWVEZaoAgNi
         I2bA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=Z4Xv5a66;
       spf=pass (google.com: domain of aryabinin@virtuozzo.com designates 40.107.5.100 as permitted sender) smtp.mailfrom=aryabinin@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=Z4Xv5a66;
       spf=pass (google.com: domain of aryabinin@virtuozzo.com designates 40.107.5.100 as permitted sender) smtp.mailfrom=aryabinin@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [PATCH v1 13/16] khwasan: add hooks implementation
To: Andrey Konovalov <andreyknvl@google.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Christopher Li <sparse@chrisli.org>,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michal Marek <michal.lkml@markovi.net>, Mark Rutland <mark.rutland@arm.com>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Yury Norov <ynorov@caviumnetworks.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Kristina Martsenko <kristina.martsenko@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Punit Agrawal <punit.agrawal@arm.com>, Dave Martin <dave.martin@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, James Morse
 <james.morse@arm.com>, Michael Weiser <michael.weiser@gmx.de>,
 Julien Thierry <julien.thierry@arm.com>,
 Tyler Baicar <tbaicar@codeaurora.org>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Kees Cook <keescook@chromium.org>, Sandipan Das
 <sandipan@linux.vnet.ibm.com>, David Woodhouse <dwmw@amazon.co.uk>,
 Paul Lawrence <paullawrence@google.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Josh Poimboeuf <jpoimboe@redhat.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Tom Lendacky <thomas.lendacky@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Dan Williams <dan.j.williams@intel.com>, Michal Hocko <mhocko@suse.com>,
 Jan Kara <jack@suse.cz>, Ross Zwisler <ross.zwisler@linux.intel.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Matthew Wilcox <mawilcox@microsoft.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Souptick Joarder <jrdr.linux@gmail.com>, Hugh Dickins <hughd@google.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Laura Abbott <labbott@redhat.com>,
 Boris Brezillon <boris.brezillon@bootlin.com>,
 Vlastimil Babka <vbabka@suse.cz>, Pintu Agarwal <pintu.ping@gmail.com>,
 Doug Berger <opendmb@gmail.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Mike Rapoport <rppt@linux.vnet.ibm.com>, Mel Gorman <mgorman@suse.de>,
 Pavel Tatashin <pasha.tatashin@oracle.com>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sparse@vger.kernel.org, linux-mm@kvack.org,
 linux-kbuild@vger.kernel.org
Cc: Kostya Serebryany <kcc@google.com>, Evgeniy Stepanov
 <eugenis@google.com>, Lee Smith <Lee.Smith@arm.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 Jacob Bramley <Jacob.Bramley@arm.com>,
 Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Kees Cook
 <keescook@google.com>, Jann Horn <jannh@google.com>,
 Mark Brand <markbrand@google.com>, Chintan Pandya <cpandya@codeaurora.org>
References: <cover.1525798753.git.andreyknvl@google.com>
 <5dddd7d6f18927de291e7b09e1ff45190dd6d361.1525798754.git.andreyknvl@google.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <f86e7172-023d-b381-64f0-6039ae1b1dce@virtuozzo.com>
Date: Tue, 15 May 2018 16:13:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <5dddd7d6f18927de291e7b09e1ff45190dd6d361.1525798754.git.andreyknvl@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0301CA0023.eurprd03.prod.outlook.com
 (2603:10a6:3:76::33) To VI1PR08MB3261.eurprd08.prod.outlook.com
 (2603:10a6:803:3d::16)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3261;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3261;3:BPrmdU8KULi7KqbOe+x6fYGFzpzetmxLoyebO41EIYyF7cX3RJ4oZlD25SCum2HYJm9TfJ9ju+QySjPNyarP3adNebvmKTvDKdEatYrbs6CJ48cer8N7ayBhZ3lfg0YksSep0UPpQgrh76LaRBWFr9nltRv/u+03f2ekb+GjKPA17iVCW2uaocC1/LbvMoDZzVEw6RbTkpQ8jJiMlINXZKChjjsHUUO9jM9+liDlgOgbCb39R/7Z1x+lK9/RvWPk;25:bDvzTK5EoHK9FqbaLGhR1YAL/RZbCBYeo8JPhlclUAM9cLSvSxEnkoY4PdTTIoNuMXp0fE62ZoL1f+STEteIpzggPubKlg7XK1KZlaW8kq+Q08m5ABdQeoyWCRw2gdLWzoqMc3wXkURMxb37RFEcKHC5DeMCdmK6qG3LL1ER0qKwwskf3t8kkLyU2JYulHxpuVxfOPrWQOuPSrAT1Yj5yRrvWsuvOXCUtrtkhNVGiMJE44k6hZLyFnwpa+d6fnf88YnXo5pFlWQXUtdZUkjq64X8E17eCDCeKvumqnWZswcERL1R7kPPbtD4iKkc6Tw+VZQzZmVb9WB/64hWLaL24g==;31:pJcm5GArY359smEnMC2G4UjhlK+ib3SwlvM5vsQz/kdJN+VcDoIBeO+aLKpDXeVWhDrnbbxe5D+HMeYhHIjyKO6ZsQ0ukRU1UNW20Wbo15vrDwzfvivmtJlIeVlFzdeP3u42godrXtEeyFkCHcLk25lZ65F2qk5e8wnIgOflfos8908zL/9K+fQJKFngCaLTjQ1Z/3L4Z4rJ3BIhfNeOLpO7eAVbjB/D76T+Vtt04Vg=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3261:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3261;20:lOB6rsoociS9gza+gHoOLIdAslbROWKRzMSrL19O6iMpGQ/Ptor2jz4zGB0dZbvoUDhuM5odNB7k72uk+rUHUqeDPRlsrnP0gl7eephAkBUxwlCPHvgOCB1X5hmp3XSw5rkMjYLmUiURZMfRVKj1YFitJ9sW4KV77SiRjtNBJGv9nd7tJ63ifel6AYgXwqaqLDTV8FlJxAllIUy12rBB4yZud5wDD/lELeINNlr+t46UBoTThz8rUOxvh2bMCvcrxcoemUDhB+6JamJXULR/qWN10hVmi+V2Yx91sPmgI2hIBz+UJnk6jpyjf4UXDf5NeyIY0VVoR+RGILkhznM04N4TwGx/QccbASFxdO60vMrIYQzr5RkYk4RbVpOM3nrk/Q9hYqZW51pkxV4vdy0mwTpAPeR67ikNZKTOiPdBCZYMI4zoawOVAhn9cjsIqS47NLjFZQb9Z4uTySClHrQ829z+4ts07LENZXh6jf26sFwu7x37y9TmT5viDbwMEo/6;4:75bxgaOxWiuVVT7D69RhXr/BGEKxsXXgZzpo60a0HKLy4wp6DWI/Ucr1JvueJWCwvO/O/hyP8yqTACMcxl3L/5iImmBsd3vot2eW2OBxQcuaAFszp4aC9knTL00HZ0Sdrze2EmoA+yWrL7BF7k5xcu5Sr4LBbbGs96OVCH2uSzoQmNGaobykwtl0Gz8e1ru0LYInRG5hR8vWr/+fnLAB6gsuntto5CEXH9vNt+o844juHkE3Og1Eqnl4auV8CFWomdW+nt1MVQvkNj6qq6QthA==
X-Microsoft-Antispam-PRVS: <VI1PR08MB32616D643D743B34700EB1DAB0930@VI1PR08MB3261.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:VI1PR08MB3261;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3261;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(376002)(366004)(346002)(39850400004)(396003)(199004)(189003)(36756003)(52116002)(76176011)(3846002)(2486003)(1191002)(110136005)(54906003)(52146003)(2906002)(81156014)(105586002)(106356001)(8676002)(59450400001)(6666003)(31686004)(23676004)(305945005)(6116002)(81166006)(55236004)(65956001)(31696002)(386003)(16576012)(86362001)(1511001)(230700001)(58126008)(316002)(53546011)(53936002)(6486002)(229853002)(47776003)(65806001)(7736002)(66066001)(8936002)(68736007)(50466002)(39060400002)(8666007)(5660300001)(6246003)(4326008)(2616005)(77096007)(26005)(65826007)(478600001)(16526019)(446003)(186003)(486006)(97736004)(11346002)(476003)(956004)(64126003)(7336002)(7406005)(7366002)(7416002)(25786009)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB3261;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4TUIzMjYxOzIzOm9SdWNhZUtENmlEVW5EY1ZYMkhFb2dXMHl0?=
 =?utf-8?B?clh4QTZ3b0RxQS9wdjdTZ0kzQzIzV1oxOGhnalNkYlNmSGgvd3VPRmN5REZt?=
 =?utf-8?B?NWZsTVpnQy9KbFd2bXUzMkdCelh3aG9WOFo5ME1RWFB6SE93dlBvM0JUUmZk?=
 =?utf-8?B?WW1ub2tobHZFK3FKeW9FemNWSlJML1RJVDBld01xY2FOQVB2NVBZTTFTQzJC?=
 =?utf-8?B?Z1hDWFFpVk9tdXU5bWRCMDFlTFNiVytDUTViMmdXeWhZTys1YS8vT29Neklo?=
 =?utf-8?B?L2JGY1VKa1VFNVNncWRsQi85Qm1wbnVZOExibnZJcE51c3RuVFRJdHZhWExY?=
 =?utf-8?B?ZHEwSEpmMlVBakFjMFh6ajRVZlc4akVucy9wVE5aRjI3ZkVxcHB2YWwwTENH?=
 =?utf-8?B?eFhOQ2ZMSEJoaVg3aG8xR2xmcnlVdHQ5Y3hQaTFSVWJJaGIxbWY0cnUvcDhP?=
 =?utf-8?B?R0ZOME9iRndtNGhacmNxeGdYL0o1eXQ4djBFNEowampsd0VOM0g0bXVtNDEz?=
 =?utf-8?B?QnpJOFFIQzgzeTByZnhoU3FVS0xVMEJzRjQ3SHovbDZ4MGNwRFhvb1prZEg1?=
 =?utf-8?B?QVhEcXpEeUk5WkdBaW1Md3lHS3kvM3dtbzBpYXY0QVRxZ3JOSXF5Um9VWHhN?=
 =?utf-8?B?QURLdG90MGt4SGxyckU0QlVGZkJtQVZkZ3JaS0tYWmdEL3VCTjBUWXhDZW9L?=
 =?utf-8?B?L05KSEV0NTZKZFlyakpRL1YrT3RmUzR0Y2RmTmE4aDF0OTBvVkttTk11b1oz?=
 =?utf-8?B?UDFKK2lpVjhyRHByenM0bmxVcS93SlcxOFNKT1ZqdFI5MWl2SFd6UWhuR3lw?=
 =?utf-8?B?aTdHY3BLVm5JcFhmZEx0TDZYcU83cE83Q0J0b3g0UytlRi91VFRZSW16S2dP?=
 =?utf-8?B?a1pFZU9CSDd5c1pMSVdUSE9vWjQ0NFZTVitmb1VKTkdiNHdkN0x3NWdjOVZj?=
 =?utf-8?B?Q2w1NWt1YVpjVjlZRnNIZWN0NHArVTNrL3RoMXcyMDdIY2o2c0s3WkVvdG9k?=
 =?utf-8?B?Ym5kQ1lIc2Y5NVhOYVRUNGJmNW4wOWxJN3ZDYmRrd1FLUk03WERCRVRiTjR1?=
 =?utf-8?B?ZUYrbEw3Qk1hWEJnWUxSbEhjNllaTFF0VXFrMjR3YnBmUElVeVl0WnZ5T2hh?=
 =?utf-8?B?ZlQ3ekltTUJxODNxSU1ZcW02NmkzYlRpcHZGUWZERjlUdDJSK0tlMjN3Y2Qz?=
 =?utf-8?B?OTNKZG9pT1lGRjVjZ3NqQnZEc0c1VmhjY2J6amR4K05HVzc3RU93SEhkVXZt?=
 =?utf-8?B?T1FpVGc5MUgremh0d0hodFZadFdPNkl1QUQrbnBBc05Yb2FDdlBNdnpTWVQ1?=
 =?utf-8?B?UlNZcGV2OXViVUI5clhpOUNnWDNYcUVQZVM2bExPbDVBZHlMTHRYdjhnZEV1?=
 =?utf-8?B?QmhmZXhvbFZXTXNVdmIvQW91NFFFRWRGOWYvdTJWV2EwYnhMcEl0LzRYQWZw?=
 =?utf-8?B?enBaMEE2cG1FOHNad2hnM0tIdXJ2VkYxbEFWNTc0WGJVQm9VL2FPeDF3QmdR?=
 =?utf-8?B?WWd2VjNsdXE3Ym9PZnIwNzFkY3VsdFRTRWJsL1lad3Yrb1ZQZFBKSXd2bDNr?=
 =?utf-8?B?WHQ5QW5YbkNsK0h0eFJkZkoxdzlPbm1UdE8vVmRuYS9HcVRaNHVsLzkwSFRO?=
 =?utf-8?B?L21UYzRKSUFnREZPVGFpeDI5MnpxRzgzYjB3amJBeFE2cFJTcnVGV3B3NE13?=
 =?utf-8?B?VHZTSU9PNk53bEpXOUNUVTZybnNSWG90SmJwVDNIYmU4UXg4S2pxc05MTmZ2?=
 =?utf-8?B?dmdZZkZGSFpFK1BxVHc3NDFFd3RMT2g2N2FWZHMxaGFmZHk4VUdXdUxZeGpL?=
 =?utf-8?B?dzBrazBDN3JxSGR1T2xZYmVNbU9rZ1k4a0lLNkxNQ0orVXdiQUl3OWpOY3BU?=
 =?utf-8?B?bGdaeUgrNk1OZ0xGajZVazkxbjJlYS9TM0RyUmtzWnhuK3J4RXBEYmhmUjM4?=
 =?utf-8?B?VmJ1V1gwaWRjNmhGdmVOM3l3STFzQVgxU2pqODRVSTBsaWJXYmZuZ1VoRlI2?=
 =?utf-8?B?bnBNRC80TUFBMDd6U0pXMHlMVDRhL1NrV0JTcCtDN21xVG90NHFTL3AyR3ox?=
 =?utf-8?B?Qjl0b2s1cDRlWEVzRVFncGwreXpTb1ZIcFBpNVZkVkh3VkRKRnhUOUR4M2s1?=
 =?utf-8?B?cWRVN3U1WnJqU1pCRTRkK3B4b1RlZk5uc3U1djk1SWx2eS9YczlSM2hhTmJ4?=
 =?utf-8?B?T0pibWQ2cmlmWWVQUzh2Uk9qVWlMWEg0YVBiNS80RGRxSGdGMm40L1dSSU1R?=
 =?utf-8?B?NlM5YTcxbHlJNmlEaHFzQVFDT1hyUkJvOHRqVko0ZmNQd2hBZ1QyUT09?=
X-Microsoft-Antispam-Message-Info: NNDK4c6L5XQQxwRWglpHBoD3rne4igb34Sfk61KJW33hj4tjM7YBeX4ke6/ik8JRWuV/Y4+rwl5WaH6Z865eVCnjOHwmhyTJxCTYwVO4gjsSJU7p2OD+veHR+rx5VgnEbnEHs2YPym4jV3SIa0UR5WV0dDOUc767HvBujogZdb3I/L/HTNJj+9+dt8S7Ujiq
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3261;6:Q2lBDK0P0OwydldMGwa26biGE9NEfE1MmVdQzBuDzeabJE3F7T+QlDNzLyL//Mdq2dzimFUmWat/Pm0Xl/k3hta/mGdG2kSwX6obhD3Iqbh1dB0O3vR1oNZ2yTlEF55kUXl68iEQJgpkSETIZ5jq9s6X4s6j6O72hAknhTesXFlLqUoHB/WKCdseIUqMwV5lWLO32sfq/Tx/EjhZwBQyuOKzUfs91LftlyPEYL7UnUxmfRJU34/TnvG0/Xs7c+aCTU9zf/Iio/Kv+6gGEjjy6Hq7ElUlquVLoPD/eGtzyHU/fuKhh0uQKgbn2RpP7YIy+/GFnOQgJX+rlXD7DqCSfGgo863vWKbyv5fOeKKaRMelpb2NeUiYabgUN9eE5R27njE8qeR7+h1c3P94DCHrFcgi5dANlGLddkLFyggZ1uWEwGPMiySFcVPf/Ye3VCBA1JdospoXdgiIoN8GNnpVzA==;5:w5wkOx93jCj/6AI1bB8GDjGh01EE1AJ5i3dHk5O4O6cPFQaSG6QYT1dXSfrkPR6Xb/lNvqzjMnKQf3VRSBHh8Nt97ZLUxLwd2E/k1Zi1oqqQJN678JAxvKELCEvQyieCJA96zLTPzXQx+wVNfMtatCzmQGodZFbAVwr9BRwZZSk=;24:s//f4v1Myh9VGjlYPKaYTDy63hg5ENIQagmP3qZ2ALcYRsrG/SmWFeWW9i14YUR+hqUNLzX72LV1NzFwIoV4mQgebk14WTVXhvAopoXvBUQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3261;7:EZfSfFGU59KiAKXIiZOqlNaQvcrp0sG5E6elhsQV4e6JTGATgJn9IqmSYmnp1TCcfqXTrutDIEOZqxI1cnKURcvx+YfqMsj5FHt/X9OfnPLsjaCmFECTPJNUlvqmaI9lSHqw/yR6PBNeJordREBKm6mAf7Twcm2OLWVAEQeQwPRLgRS9W2dHMrUmkJOQJJRDhHygt6X2R79n/F56wlhHJRw2Ftx/CGQavbZ47yIj6YCY0JcMiJ0iZeu6zx4+ZNtD;20:WT76jYOuhhc1C7vfd8CWeMy6hf8cLBbywwxY0Nmnegz+yGaloY0mhfiKQS5iSkfRyXT+8/s0zOBlOesnguqzaHf8rTqQyBj5j8jbMhuQDW+Jw//SKdyuokqpun3nQPS7gD4Ju7od9Y7yWR3gPQZgkZ53CXXeNH91a8rI95nxWag=
X-MS-Office365-Filtering-Correlation-Id: cd37007b-6928-4f6f-d83c-08d5ba658062
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 13:12:15.4966 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd37007b-6928-4f6f-d83c-08d5ba658062
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3261
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599917368699332445?=
X-GMAIL-MSGID: =?utf-8?q?1600535865552066261?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 05/08/2018 08:20 PM, Andrey Konovalov wrote:

>  
>  static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
>  			      unsigned long ip, bool quarantine)
>  {
>  	s8 shadow_byte;
> +	u8 tag;
>  	unsigned long rounded_up_size;
>  
> +	tag = get_tag(object);
> +	object = reset_tag(object);
> +
>  	if (unlikely(nearest_obj(cache, virt_to_head_page(object), object) !=
>  	    object)) {
> -		kasan_report_invalid_free(object, ip);
> +		kasan_report_invalid_free(set_tag(object, tag), ip);

Using variable to store untagged_object pointer, instead of tagging/untagging back and forth would make the
code easier to follow.

>  		return true;
>  	}
>  
> @@ -326,20 +346,29 @@ static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
>  		return false;
>  
>  	shadow_byte = READ_ONCE(*(s8 *)kasan_mem_to_shadow(object));
> +#ifdef CONFIG_KASAN_GENERIC
>  	if (shadow_byte < 0 || shadow_byte >= KASAN_SHADOW_SCALE_SIZE) {
>  		kasan_report_invalid_free(object, ip);
>  		return true;
>  	}
> +#else
> +	if (tag != (u8)shadow_byte) {
> +		kasan_report_invalid_free(set_tag(object, tag), ip);
> +		return true;
> +	}
> +#endif



static bool inline shadow_ivalid(u8 tag, s8 shadow_byte)
{
	if (IS_ENABLED(CONFIG_KASAN_GENERIC))
		return shadow_byte < 0 || shadow_byte >= KASAN_SHADOW_SCALE_SIZE;
	else
		return tag != (u8)shadow_byte;
}


static bool __kasan_slab_free(struct kmem_cache *cache, void *object,

...
	if (shadow_invalid(tag, shadow_byte)) {
		kasan_report_invalid_free(object, ip);
		return true;
	}


>  
>  	rounded_up_size = round_up(cache->object_size, KASAN_SHADOW_SCALE_SIZE);
>  	kasan_poison_shadow(object, rounded_up_size, KASAN_KMALLOC_FREE);
>  
> -	if (!quarantine || unlikely(!(cache->flags & SLAB_KASAN)))
> +	if ((IS_ENABLED(CONFIG_KASAN_GENERIC) && !quarantine) ||
> +			unlikely(!(cache->flags & SLAB_KASAN)))
>  		return false;
>  
>  	set_track(&get_alloc_info(cache, object)->free_track, GFP_NOWAIT);
>  	quarantine_put(get_free_info(cache, object), cache);
> -	return true;
> +
> +	return IS_ENABLED(CONFIG_KASAN_GENERIC);
>  }
>  
>  bool kasan_slab_free(struct kmem_cache *cache, void *object, unsigned long ip)
> @@ -352,6 +381,7 @@ void *kasan_kmalloc(struct kmem_cache *cache, const void *object, size_t size,
>  {
>  	unsigned long redzone_start;
>  	unsigned long redzone_end;
> +	u8 tag;
>  
>  	if (gfpflags_allow_blocking(flags))
>  		quarantine_reduce();
> @@ -364,14 +394,19 @@ void *kasan_kmalloc(struct kmem_cache *cache, const void *object, size_t size,
>  	redzone_end = round_up((unsigned long)object + cache->object_size,
>  				KASAN_SHADOW_SCALE_SIZE);
>  
> +#ifdef CONFIG_KASAN_GENERIC
>  	kasan_unpoison_shadow(object, size);
> +#else
> +	tag = random_tag();
> +	kasan_poison_shadow(object, redzone_start - (unsigned long)object, tag);
> +#

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 7cd4a4e8c3be..f11d6059fc06 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -404,12 +404,9 @@ void *kasan_kmalloc(struct kmem_cache *cache, const void *object, size_t size,
 	redzone_end = round_up((unsigned long)object + cache->object_size,
 				KASAN_SHADOW_SCALE_SIZE);
 
-#ifdef CONFIG_KASAN_GENERIC
-	kasan_unpoison_shadow(object, size);
-#else
 	tag = random_tag();
-	kasan_poison_shadow(object, redzone_start - (unsigned long)object, tag);
-#endif
+	kasan_unpoison_shadow(set_tag(object, tag), size);
+
 	kasan_poison_shadow((void *)redzone_start, redzone_end - redzone_start,
 		KASAN_KMALLOC_REDZONE);
 


>  	kasan_poison_shadow((void *)redzone_start, redzone_end - redzone_start,
>  		KASAN_KMALLOC_REDZONE);
>  
>  	if (cache->flags & SLAB_KASAN)
>  		set_track(&get_alloc_info(cache, object)->alloc_track, flags);
>  
> -	return (void *)object;
> +	return set_tag(object, tag);
>  }
>  EXPORT_SYMBOL(kasan_kmalloc);
>  



> @@ -380,6 +415,7 @@ void *kasan_kmalloc_large(const void *ptr, size_t size, gfp_t flags)
>  	struct page *page;
>  	unsigned long redzone_start;
>  	unsigned long redzone_end;
> +	u8 tag;
>  
>  	if (gfpflags_allow_blocking(flags))
>  		quarantine_reduce();
> @@ -392,11 +428,16 @@ void *kasan_kmalloc_large(const void *ptr, size_t size, gfp_t flags)
>  				KASAN_SHADOW_SCALE_SIZE);
>  	redzone_end = (unsigned long)ptr + (PAGE_SIZE << compound_order(page));
>  
> +#ifdef CONFIG_KASAN_GENERIC
>  	kasan_unpoison_shadow(ptr, size);
> +#else
> +	tag = random_tag();
> +	kasan_poison_shadow(ptr, redzone_start - (unsigned long)ptr, tag);
> +#endif
>  	kasan_poison_shadow((void *)redzone_start, redzone_end - redzone_start,
>  		KASAN_PAGE_REDZONE);
>  
> -	return (void *)ptr;
> +	return set_tag(ptr, tag);
>  }

kasan_kmalloc_large() should be left untouched. It works correctly as is in both cases.
ptr comes from page allocator already already tagged at this point.
