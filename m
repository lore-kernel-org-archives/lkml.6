Return-Path: <aryabinin@virtuozzo.com>
X-Google-Smtp-Source: AIpwx4+mDPfaoFm6BCITYsvcwleHhdfZe//Uw5jhhqm24/JGUUmMc/D9XsWwYHtbRmd6u9ZXuNXJ
ARC-Seal: i=1; a=rsa-sha256; t=1522426350; cv=none;
        d=google.com; s=arc-20160816;
        b=iML0lMqTs8+4WAoOwzEnTwV5TPv9t+dcG3CRKXFlKf4fyIujxdt220PU3YcxTgEDpd
         7CcZh9BR5G7KFCM9cVqpocp/R5Bl5UalF/Qhq65uj79/7XVRprGQktSXudHTYi6ucdkf
         mIOoHTMFKjQKw8caskmMzKRPYqfmYtj+zQw+NBvAxIzBqMKkr9b05TpJDf+7RVhzgMeu
         fGOTETp6URJ4BJWjFFdARfHELXp55K18DUgGjVIcPK1Zlg5ApGbh02YNqgMuCVjcJJ5i
         EA8hB0dWlmVtskfVrffb0+d5cmzzquXMT+MiQngujx554+ijoCuF4kv89Igxo8qkgpqR
         hV4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=Hcpdw0kRcUi6p1VaZHidpMPjDX2uLsFoWyNSlm3tGlI=;
        b=NING9THPhLJONfg3VudTDBWv7ilSH+att/7thht2RjxDh1mt2Ib4enB+NC12IF3Q29
         fHq0cVFiaiDt/fkdpnTbkXOhff24NqlSqbFxz+xk+8E2yaBul0WpdqQN4OFcpEX/XdM3
         t/9eBxXVr5QLBXIHXsMwPbidqvNhU2YTPFtiIBjYcQ2enplXAUv1RmGbyhLZXZ9/K66E
         o9oERvk51/NbrIlXikCu5wvVAxyI/SdENhwgsUVuVg5+o0hy3pKSecu20IfUcMztBvgf
         2PhjdQvIVfXt9YeabyPEfoxCCGrNTWONQNCWgdPgtClaXes0UlCj20e1v2vaLkDc2sPF
         v+fA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=K9mDgwIu;
       spf=pass (google.com: domain of aryabinin@virtuozzo.com designates 104.47.0.130 as permitted sender) smtp.mailfrom=aryabinin@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=K9mDgwIu;
       spf=pass (google.com: domain of aryabinin@virtuozzo.com designates 104.47.0.130 as permitted sender) smtp.mailfrom=aryabinin@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [RFC PATCH v2 08/15] khwasan: add tag related helper functions
To: Andrey Konovalov <andreyknvl@google.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Christopher Li <sparse@chrisli.org>, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michal Marek <michal.lkml@markovi.net>, Mark Rutland <mark.rutland@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Yury Norov <ynorov@caviumnetworks.com>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Kristina Martsenko <kristina.martsenko@arm.com>,
 Punit Agrawal <punit.agrawal@arm.com>, Dave Martin <Dave.Martin@arm.com>,
 Michael Weiser <michael.weiser@gmx.de>, James Morse <james.morse@arm.com>,
 Julien Thierry <julien.thierry@arm.com>, Steve Capper
 <steve.capper@arm.com>, Tyler Baicar <tbaicar@codeaurora.org>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Paul Lawrence <paullawrence@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Woodhouse <dwmw@amazon.co.uk>,
 Sandipan Das <sandipan@linux.vnet.ibm.com>, Kees Cook
 <keescook@chromium.org>, Herbert Xu <herbert@gondor.apana.org.au>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, linux-sparse@vger.kernel.org,
 linux-mm@kvack.org, linux-kbuild@vger.kernel.org
Cc: Kostya Serebryany <kcc@google.com>, Evgeniy Stepanov
 <eugenis@google.com>, Lee Smith <Lee.Smith@arm.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 Jacob Bramley <Jacob.Bramley@arm.com>,
 Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Kees Cook
 <keescook@google.com>, Jann Horn <jannh@google.com>,
 Mark Brand <markbrand@google.com>
References: <cover.1521828273.git.andreyknvl@google.com>
 <b79947167d09478d3f61d2ec8de37322c0e1fe92.1521828274.git.andreyknvl@google.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <a724eee6-7aff-df8b-de2b-8e9446e94623@virtuozzo.com>
Date: Fri, 30 Mar 2018 19:13:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <b79947167d09478d3f61d2ec8de37322c0e1fe92.1521828274.git.andreyknvl@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0401CA0044.eurprd04.prod.outlook.com
 (2603:10a6:3:19::12) To AM0PR08MB3249.eurprd08.prod.outlook.com
 (2603:10a6:208:5e::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d4ab2a2-c2f6-4e8e-c124-08d596590614
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3249;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3249;3:M6MREYG28iNpLevo1Pmfm0LInu8SGk+MD6vtEYk6nODlSpTWynu3WaZujoZsq99ByBJTso5oW0pIF96jiBs8j+oYG3SQxrC6WGhlfRSLiUdUcIe0Ol5Gldo7vhUPqJ8Vfdr5dy+/Lm3Lmbi9QoWn6uwWmbq5Lmpm6FEduNNDt/kCSs8v9fAB5gzz7YUxyHvljMVhq/vK55FVKDWoQcHUpLx/haIttsZg0l9qPEBaWeIQJ8kDlknJ7kff69laJbyK;25:dmnqKcs83DIP0bW9rED/iPtSet2cqbab6hHgYJM3yv7rlmR77uecrvKZwfBfGm7LahPIymnV4f6Y+jiQJmbT8EjorxKyyXf8UALurwSodUt98sXjSjrKVljt+kyJMmhQiY1lqxaJB6JTGwmFjvoJ/6HXbr5vk5Mc18sBcnpCLfLvfpWbH4fsFqgpbywqQSAeR+LcSy7QTsybNdakT1mw9V8xuyREsx+mzXyO0CGRZdGnWcsSfwzNkQXqpkVTsRJlJyNZ3n1HiZ051GKfzYn20tXoErBXEkkcFek3sRWk6zNc0Wu8m0AZ47psri+ZiLKrLspXkZTCL8nOsQG0Cb4qCA==;31:W6WpE4iiKxTBjS+r091UwNrSrm6nPx219mRR/RQ3fioriuz4MfWDHbYcugejkSdRJ62HglIdmXwuATKs/0ABxTZHKPcifnS5xda3J1a9zVYsdG1TycNPrFEcardEyC2vMiWQVktnHvV81EYWPuwW61LPsv9MZV/RFO8jPvWJ9WkKqlI+jRA9M8W4FJKFow3FgUNStyGDRTmTkHvvTxDhgxrISha1dQHz3H+01/krr8k=
X-MS-TrafficTypeDiagnostic: AM0PR08MB3249:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3249;20:OIZUXHLyZqYKIYTK3AmT/eh0Jxemkvf/lMeIdPK81gEcH+vDLhB5DiqYRQEwfUsf2XhTo24UpNI5YlEGWu+u76YtP4TWc5Tk78fX7LoD/cw5mz2z6io98i8nJTXSwW5qe9hp7imaB50lIhvP/kwETrt6CLSwe2EsF3CchcENJma59Ixz/z0K/HilLZ563hqYVPpIN9V62k6MFL8A7VlgK+BPkDegTa00rEybE+5Z3hrVCOIDzy9MNCv6UobUqAHLTwwMnUXMiECGw+7nuIzt5vlmg+QxY3wdwCI+5FTFtOCRxjNk+lAgtve9ggvYXTlQ1m0a4lRk9mAW5ceOq5GhhtXeHAUDBqYEcsRE2ZkoWLMHnZOLSg9V7o4VmbHuGNSQikuag1NOZTiV57DJW3KHab0+oN7N7/Ikwb1/btgRgOu4XOHDz62dzSu3FkuUA0ywHrM8qqZfisPhGv0DRboVRngMmKXwZ66jqIY8m66Kv7qSVpVLYiW/riSo/5j8EpZ4;4:RYlWBSakDHYHoh3XvhxN+SN1Nh18f4KaFPPanJA0D6od2GmTBK2xVSUSvomX3hP8WmXfIMT90gBS251SpivnMhtz7bjnQRdex0iHoNh2iYBihuGZNQbOgINrKcVyWA43afPWacKYevuVRXgvz/JNbrTmOLS8lMN9Vwkgkax/ibncqKj//xJRrg0yDzwfY8J3eJWqA3q7XVdkkc2p/z8KyGWs1hD/BWhe9leCxOuHBOgWO+iTsWpKAt90boyAAgiCDXZ+MdRK90BYJ1cch4TQCg==
X-Microsoft-Antispam-PRVS: <AM0PR08MB3249A2F4007E8065462EE2D9B0A10@AM0PR08MB3249.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(10201501046)(93006095)(93001095)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:AM0PR08MB3249;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3249;
X-Forefront-PRVS: 06274D1C43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(39380400002)(39840400004)(346002)(366004)(376002)(189003)(199004)(3846002)(53546011)(230700001)(7406005)(956004)(7416002)(5660300001)(68736007)(2616005)(446003)(386003)(66066001)(11346002)(7366002)(6116002)(65956001)(2486003)(2906002)(47776003)(31696002)(186003)(86362001)(76176011)(229853002)(65826007)(486005)(16526019)(77096007)(55236004)(65806001)(476003)(486005)(26005)(31686004)(478600001)(97736004)(53936002)(6246003)(7736002)(50466002)(52116002)(25786009)(8666007)(4326008)(8936002)(6666003)(305945005)(6486002)(81156014)(36756003)(8676002)(64126003)(106356001)(2171002)(54906003)(81166006)(16576012)(105586002)(110136005)(316002)(58126008)(23676004)(52146003)(921003)(1121003)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR08MB3249;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjA4TUIzMjQ5OzIzOmRqM3h4Znd3bUJyUXdXUXNEaS8xOFdkcnBG?=
 =?utf-8?B?b2xLOGdCeEt0MXZucXBINDlnWVo2VGlVNEtKbVJpd2JDNVRkN1VpaytMTlJ6?=
 =?utf-8?B?T0ZwUUhvUitoenJldzBSZGNuVkdFeUhUbzQvWkQ3VGQvcFdMSkttZDl6N1lC?=
 =?utf-8?B?ZTdlNlQxVkpRdVRKWUFLWnVlT1NsQ2x5NGFiVnF3ZWZDRkZmSzBoQ243NjUw?=
 =?utf-8?B?Y1NablFtYlhpYTRVSUI1c3pQRUdpdFBicjNxR0JQLytLMDVCZUFpSWlHcUNK?=
 =?utf-8?B?QmVVVGJHZGpBWTI5UVR5SFdSYzkzTE5ENEJEaldXaHlrbVNTeXkxRUJ1NHdP?=
 =?utf-8?B?bzZVbWtqSmlzamNKUTAxcFMvMGlySmozNTdnbDNtN1ErZGpQUm1MUjZHeUhT?=
 =?utf-8?B?WmJ2Y1A2Y0txWm9KeHdRdnl2T3MwaGpRV2tHQ2ZwUUp3RDlOSXV5c3JxVk5o?=
 =?utf-8?B?c3dHNG1ndW5uNUpvcGlmOU9GSTRYNUpIWW1ZUFA3b2wvbkhjS2k0b0tGd0lp?=
 =?utf-8?B?TjFFcUFMNjRJR1g4Z2QxZEVLOHFLcW16YUI3eTBDSlR6b1Rvc21tUWtGaXJt?=
 =?utf-8?B?Mk02OGJoZmNCQXNoSFJMczdocDFBTElpQW1yNmlYcjc5WXZrTHRkandlVVhP?=
 =?utf-8?B?V2lVeVhtcjdMUEprWUNPT1RIOGducEN5OTRkdVBET1Vya2VwcWFhbzRTQ0xO?=
 =?utf-8?B?SittTURDbU5Jc0VhTm9pN2JxKzJIVTlhaSsxNGtmODZYbmh1eldLL0prcHBx?=
 =?utf-8?B?N3ZlbXVSWGhFMTF2bHpPZUlpRGd5TlVmZEluMWZvdVo3RFIvWmlPWWZQb2VE?=
 =?utf-8?B?cUl0eGlLaEVHSGo4bzhOMnZzeURJMFY0bGozaCs5eG1DMjBaOW91VTRKZEtS?=
 =?utf-8?B?SlF1a3dmOVlYYUptdUE3ZTV4ODY3M0gvdXo5d2Z1Vm5pSnJxbFNNekxOQXBS?=
 =?utf-8?B?cDRGWTVHcHpzMGpmNXpZU0p5NDd1WU1ocmpMbHZOOW8rYlE1OEwrdDZSdjY0?=
 =?utf-8?B?UDRlSXI2WVRIdzZCL2xtOFErMEdqU3lCWlpUekU1dWtnbXpYRW9vcXFtYmZH?=
 =?utf-8?B?V3E2VWptZGx6YUliVlhRK3hRTVBGMXhBNXVxdFJ0M21GYXBGdmMwUmdXQVFz?=
 =?utf-8?B?K0lLR1phUDhDbXFuZEVJL3lLeldXQmJ5YVovSUVqREgySkdWQ2loYW9QY1NT?=
 =?utf-8?B?U2FmS3FoM3NBd0l6aXcwL3ZhK2Q4UWFhVTRaRU5oOWVCbmtZc2RTYTV2SERW?=
 =?utf-8?B?TGZISVp6ZW05NnB6OEx1eENCRkp1eC9yQmxxYWk2bXh3a0dzQnh6a1dIQkxt?=
 =?utf-8?B?YU1BanNjNGVibUhSRGg0bGY1THMxMWYyTG9jclQ3OGVFRFZVSUo3c2txQlJ3?=
 =?utf-8?B?aTU5b252b0Fra01yTWh5Z3o5RExtOU1XbVgzMDNlZmRpblZRbDRzWHlQUlZR?=
 =?utf-8?B?MEVnSFJCMlE3ckN6cmRTWVNWdkRQTklKYXVQQlBQeDJtZWNhMU8yOVBLL1hj?=
 =?utf-8?B?MUhnZlNxYzd3dDliSnhDdEpFd1l4L2hFYUJMNWV0UzBIVWcvWW4xd2pkV2p3?=
 =?utf-8?B?YjVLN1QwTkZqN3NTTnZsWm5PTU5KWktwdVZ4Z0NhcDN4QzVuU29PMXZKbUx2?=
 =?utf-8?B?bEFPaUUzVUVnWmhCZWJzQnNEOHJaMUVpL0VNNElmMDhJZEFkb3JjcXdDTlJp?=
 =?utf-8?B?cVA0d3ByVFhOYXBFRmdOTy9SYUl1blRKbkNRd3VXQ2dTWnVMaGlSMXJINkEv?=
 =?utf-8?B?dHBrZGFIOXkrU2RQV2ROSmwydHNENkFhRFpHNEpDUStIOEFvSXdOTFYwUm1h?=
 =?utf-8?B?T0tSQWFqT2ZwZ1YwazZLWis2dWF1TFFvZjVuQlJ1RnBlMzY0bmdaWmROR1NU?=
 =?utf-8?B?eVovKzVPcURWdnZJWFBtYUVUQ0wwOFpYRmlqQjFxZm5jcHJja2pGc2s4bGJ6?=
 =?utf-8?B?MkY2NnNGT0dySnZLc0xweDNNL0lxWlJoMTl3YkI3d294akhoVzU4MXlvUW1s?=
 =?utf-8?B?dHp5OFRSMGx1b3lwRkRBdGJoczE0V3czOWt3MEQ5V0c4citUK0htYzgxeDJK?=
 =?utf-8?B?UCttRkVPOGZZTWd3WDJUVnNWL25udDFVSmxLSkRWdnhQSDByMDU3SldMMzFw?=
 =?utf-8?B?aXVVd3NSL0VvQjJkdnVBNlcyMWlzWEdUa0R0TEx3VzRZck1SZXlFYjJVRzBM?=
 =?utf-8?B?alh0RnM1STJoRkx3bDlWYUJxWFZBPT0=?=
X-Microsoft-Antispam-Message-Info: oE+QThqPj8Q1M7HHp0ud4GRsuqgIdbWQrc9OlCTLSu0Ma2HKIpkjg0julFcvxtWnOyRpNiTOw8xyWKQHNvQDcZJgFate+b7qQ/WldkyKClxbfBeyIuX34sRcko5futUUOU6FfpRQ0RPixWrgpf8TXLObqvMTxrRMogdXct5M1wVLMzfSyXxTs0Px9VED70dB
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3249;6:HZz4diXkdLAWLpu9tbWxkX+QR2PjcIgTuWJbohBQ0UpYLnbDt69qDH6DZdgt17LPrGRZIYM2qA6t7l8OcVljhw3W1usQqiwl33X+EV5cCgf6k3qoDU9jLQ2400l42hqfupLzDtr1wqNm0/hICgRp6HLczUEYs+22+4jMa2WqTDBfRaHJb5zFrptv32DfxUINHkcgF42ENdwH5sKBsOzG7CbhQm1LX86YavAVWDADHJzwgDeJML84uGxN1vC1G1ESc38qRJB6+Go2VtqdkMvJabg9VOTnhHyuE8HfJDc6rP9Uj5YU2IAMHmI1M74cPxLTKTJiggUSBdmlUmh1HTuy727tdpqoCw0scVYquBwJIwkrCcI9hXdNip884buCpqUWEBfgKxU+aSedshtyDj4zLCawH8ATjb7s0w44a3aDPs0g960EMXO79ekFD+OPz2pv7CGuumSksE/zc+E2RFeJ7Q==;5:RIKhbF+l+uDpOH04LpgyHtdFlyq++WhA4MIwXizG9Woe2jwlHIfywcS0pbsAe5UPgAW3+SkzqJsdY98n40dHuLEoSimOLvm/tLpENCpQA2dBjTaG8iif+JULRw57IxFUCLa5913Wp9foaE68/wEZzhKLdIzDQ+E4KxdHHF8r1j8=;24:KBJcMP+NEbto7ymenv/HoODYmcgrH2zjHrUDRxqSXBm2b/NNgmNtR65zUJ/ND8DJTia732K39PFagaN9rntR0pHE1ViPudWcPUlICDoq7AU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3249;7:rQzydQodu1bV3fRTYvuN3FWn+apTYNvIMdXdXD2uqOo01ZnxJNdwzM2+jUz0HvmrhQeGfgwzv+mvEh1MRyMn9k8jnQ0Impin+eZRByJPIw2vNRls2KAzUEk1pPNRpLxLwWOKJPKeNSPQ5qLkcv5gzf0qE1oaIdExN0c34tmCSEt2E40AXY2bz1DRXJjTwqYrSsxr652vhkg7N+VVZo1sLR9dpkBoDMmH+RoZGcoNViSrKZWf3k+7gvjBFIM2T8KO;20:3tu0Pqe649QeQbXOhDLXgacn3qcx0d/gjOq6uExtCj1Mmxw1VeXWTL+XOCoPevEsXnTTxJITYIhQX0sl7HhyT8ij6xfcbob6+AHpv4ekyBqR8/MMGDitf5ly/zDJiSEfvF+kBxo7sJICOoS/2PosHvuMLomr1iROAnVn7bTJTEg=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2018 16:12:20.5915 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4ab2a2-c2f6-4e8e-c124-08d596590614
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3249
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595752710383893280?=
X-GMAIL-MSGID: =?utf-8?q?1596379732674958805?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/23/2018 09:05 PM, Andrey Konovalov wrote:

> diff --git a/mm/kasan/khwasan.c b/mm/kasan/khwasan.c
> index 24d75245e9d0..da4b17997c71 100644
> --- a/mm/kasan/khwasan.c
> +++ b/mm/kasan/khwasan.c
> @@ -39,6 +39,57 @@
>  #include "kasan.h"
>  #include "../slab.h"
>  
> +int khwasan_enabled;

This is not unused (set, but never used).

> +
> +static DEFINE_PER_CPU(u32, prng_state);
> +
> +void khwasan_init(void)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		per_cpu(prng_state, cpu) = get_random_u32();
> +	}
> +	WRITE_ONCE(khwasan_enabled, 1);
> +}
> +
