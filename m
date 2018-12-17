Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B285C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C348214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731545AbeLQWey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 17:34:54 -0500
Received: from mout.gmx.net ([212.227.17.22]:36911 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727597AbeLQWey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 17:34:54 -0500
Received: from [192.168.123.38] ([84.118.159.3]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M2Glc-1hR7Zz3xnI-00s5kP; Mon, 17
 Dec 2018 23:33:52 +0100
Subject: Re: [tip:efi/urgent] efi: Align 'efi_guid_t' to 64 bits
To:     cai@gmx.us, torvalds@linux-foundation.org, mingo@kernel.org,
        bp@alien8.de, dave.hansen@linux.intel.com,
        ard.biesheuvel@linaro.org, linux-kernel@vger.kernel.org,
        luto@kernel.org, tglx@linutronix.de, riel@surriel.com,
        hpa@zytor.com, peterz@infradead.org,
        linux-tip-commits@vger.kernel.org
References: <20181217180214.9436-3-ard.biesheuvel@linaro.org>
 <tip-793423cf07e51e3185b8680167115813589c057d@git.kernel.org>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Openpgp: preference=signencrypt
Autocrypt: addr=xypron.glpk@gmx.de; prefer-encrypt=mutual; keydata=
 mQINBE2g3goBEACaikqtClH8OarLlauqv9d9CPndgghjEmi3vvPZJi4jvgrhmIUKwl7q79wG
 IATxJ1UOXIGgriwoBwoHdooOK33QNy4hkjiNFNrtcaNT7uig+BG0g40AxSwVZ/OLmSFyEioO
 BmRqz1Zdo+AQ5RzHpu49ULlppgdSUYMYote8VPsRcE4Z8My/LLKmd7lvCn1kvcTGcOS1hyUC
 4tMvfuloIehHX3tbcbw5UcQkg4IDh4l8XUc7lt2mdiyJwJoouyqezO3TJpkmkayS3L7o7dB5
 AkUwntyY82tE6BU4quRVF6WJ8GH5gNn4y5m3TMDl135w27IIDd9Hv4Y5ycK5sEL3N+mjaWlk
 2Sf6j1AOy3KNMHusXLgivPO8YKcL9GqtKRENpy7n+qWrvyHA9xV2QQiUDF13z85Sgy4Xi307
 ex0GGrIo54EJXZBvwIDkufRyN9y0Ql7AdPyefOTDsGq5U4XTxh6xfsEXLESMDKQMiVMI74Ec
 cPYL8blzdkQc1MZJccU+zAr6yERkUwo1or14GC2WPGJh0y/Ym9L0FhXVkq9e1gnXjpF3QIJh
 wqVkPm4Two93mAL+929ypFr48OIsN7j1NaNAy6TkteIoNUi09winG0tqU5+U944cBMleRQOa
 dw+zQK0DahH4MGQIU0EVos7lVjFetxPjoKJE9SPl/TCSc+e0RwARAQABtChIZWlucmljaCBT
 Y2h1Y2hhcmR0IDx4eXByb24uZ2xwa0BnbXguZGU+iQI4BBMBAgAiAhsDBgsJCAcDAgYVCAIJ
 CgsEFgIDAQIeAQIXgAUCVAqnzgAKCRDEgdu8LAUaxP7AD/9Zwx3SnmrLLc3CqEIcOJP3FMrW
 gLNi5flG4A/WD9mnQAX+6DEpY6AxIagz6Yx8sZF7HUcn1ByDyZPBn8lHk1+ZaWNAD0LDScGi
 Ch5nopbJrpFGDSVnMWUNJJBiVZW7reERpzCJy+8dAxhxCQJLgHHAqPaspGtO7XjRBF6oBQZk
 oJlqbBRFkTcgOI8sDsSpnsfSItZptoaqqm+lZpMCrB5s8x7dsuMEFaRR/4bq1efh8lSq3Kbf
 eSY59MWh49zExRgAb0pwON5SE1X9C84T2hx51QDiWW/G/HvJF2vxF8hCS7RSx0fn/EbPWkM6
 m+O1SncMaA43lx1TvRfPmYhxryncIWcez+YbvH/VqoLtxvz3r3OTH/WEA5J7mu5U1m2lUGNC
 cFN1bDsNoGhdlFZvG/LJJlBClWBWYHqHnnGEqEQJrlie9goBcS8YFUcfqKYpdmp5/F03qigY
 PmrE3ndBFnaOlOT7REEi8t3gmxpriTtGpKytFuwXNty1yK2kMiLRnQKWN7WgK70pbFFO4tyB
 vIhDeXhFmx6pyZHlXjsgbV3H4QbqazqxYOQlfHbkRpUJczuyPGosFe5zH+9eFvqDWYw2qdH+
 b0Nt1r12vFC4Mmj5szi40z3rQrt+bFSfhT+wvW9kZuBB5xEFkTTzWSFZbDTUrdPpn2DjYePS
 sEHKTUhgl7kCDQRNoN4KARAA6WWIVTqFecZHTUXeOfeKYugUwysKBOp8E3WTksnv0zDyLS5T
 ImLI3y9XgAFkiGuKxrJRarDbw8AjLn6SCJSQr4JN+zMu0MSJJ+88v5sreQO/KRzkti+GCQBK
 YR5bpqY520C7EkKr77KHvto9MDvPVMKdfyFHDslloLEYY1HxdFPjOuiMs656pKr2d5P4C8+V
 iAeQlUOFlISaenNe9XRDaO4vMdNy65Xrvdbm3cW2OWCx/LDzMI6abR6qCJFAH9aXoat1voAc
 uoZ5F5NSaXul3RxRE9K+oWv4UbXhVD242iPnPMqdml6hAPYiNW0dlF3f68tFSVbpqusMXfiY
 cxkNECkhGwNlh/XcRDdb+AfpVfhYtRseZ0jEYdXLpUbq1SyYxxkDEvquncz2J9urvTyyXwsO
 QCNZ0oV7UFXf/3pTB7sAcCiAiZPycF4KFS4b7gYo9wBROu82B9aYSCQZnJFxX1tlbvvzTgc+
 ecdQZui+LF/VsDPYdj2ggpgxVsZX5JU+5KGDObBZC7ahOi8Jdy0ondqSRwSczGXYzMsnFkDH
 hKGJaxDcUUw4q+QQuzuAIZZ197lnKJJv3Vd4N0zfxrB0krOcMqyMstvjqCnK/Vn4iOHUiBgA
 OmtIhygAsO4TkFwqVwIpC+cj2uw/ptN6EiKWzXOWsLfHkAE+D24WCtVw9r8AEQEAAYkCHwQY
 AQIACQIbDAUCVAqoNwAKCRDEgdu8LAUaxIkbD/wMTA8n8wgthSkPvhTeL13cO5/C3/EbejQU
 IJOS68I2stnC1ty1FyXwAygixxt3GE+3BlBVNN61dVS9SA498iO0ApxPsy4Q7vvQsF7DuJsC
 PdZzP/LZRySUMif3qAmIvom8fkq/BnyHhfyZ4XOl1HMr8pMIf6/eCBdgIvxfdOz79BeBBJzr
 qFlNpxVP8xrHiEjZxU965sNtDSD/1/9w82Wn3VkVisNP2MpUhowyHqdeOv2uoG6sUftmkXZ8
 RMo+PY/iEIFjNXw1ufHDLRaHihWLkXW3+bS7agEkXo0T3u1qlFTI6xn8maR9Z0eUAjxtO6qV
 lGF58XeVhfunbQH8Kn+UlWgqcMJwBYgM69c65Dp2RCV7Tql+vMsuk4MT65+Lwm88Adnn6ppQ
 S2YmNgDtlNem1Sx3JgCvjq1NowW7q3B+28Onyy2fF0Xq6Kyjx7msPj3XtDZQnhknBwA7mqSZ
 DDw0aNy1mlCv6KmJBRENfOIZBFUqXCtODPvO5TcduJV/5XuxbTR/33Zj7ez2uZkOEuTs/pPN
 oKMATC28qfg0qM59YjDrrkdXi/+iDe7qCX93XxdIxpA5YM/ZiqgwziJX8ZOKV7UDV+Ph5KwF
 lTPJMPdQZYXDOt5DjG5l5j0cQWqE05QtYR/V6g8un6V2PqOs9WzaT/RB12YFcaeWlusa8Iqs Eg==
Message-ID: <8cfd64a9-1a66-0ca1-851b-c3fc9a47809d@gmx.de>
Date:   Mon, 17 Dec 2018 23:33:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <tip-793423cf07e51e3185b8680167115813589c057d@git.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:4eEnV6QIyWZGadyS0e4CQA55zydpv3z+J7lJcsmOr8uOEmQzbT7
 LFD6QUYCKUUGnYAus9tDuM8ITXALk8zJh8mP8vIM+Zo7r6gDNI0jA/wazshSLNFQeibhp93
 dwGaROdCyB3KtCF8TJ9HkY8iU4VC04IMzEZ0DykH0RdcK91ah31g+LYUkH1b04S2hwTO75F
 7c0p0d0RGIIeSuZnmfJ1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U2cLDf9MIio=:ZXZlo986nTUxwv15KTAVHr
 yCTDZmKF5BtnOZMtBvlkG7miVj8kvoNbaALLpVwgK/xHdLtjaoWNCyNQfcOd+WcboLqTwbHcf
 mIiFRzQzEmnmwgHX0U43Uxxyt6XAh3j8aabDCUg7iYdjSVPOtnJCuU2eQE5hirG+WnNxNGl5p
 7bHK+gGwf2wXz/34w81ecLjL+gbgi4qoSGrx0BAqL+B/uMwBj1PvbcK50vZZN4cZCTch+G2d3
 y0IVPfP4A2x4BSvhjthcADM87mKExpJIgrfkZ88l0wmrqkhNKn2w3ziLTXLWKg7TVJYxfLTsG
 ubU1KmdoSdK72ajIHJ4k8D10skfJu4l1jxG2FpyuKivN08byoTwe/J63P4r5o7dGtiUAkIxji
 yIsn/qredXEanV+GhM+3ovt1l+KF9/WbmeoVLrh6sW4A2R1Jqek6Kw9x1kct57YIDd8bbm7sk
 MM0mGdHb13OW01kIdbPctZ9rGw+07VwcVjbkVP1qc/Y78NMBcARuUIiNk3UxV8yfnagWJ47Ip
 wXAppilNiPdHBPK9pA4KEc1xh1Eo0Mp2OUfj+WVoO4EFgxjQKafwAtt8nKqS3qeywC3TltITy
 mrhmNaQsMrX1lRPHfsYnT8CU/4sd+AJX3kuMFLtCg+zbAwzXlfHSwhB+Qxwa7sCxBnUPp4Xep
 bX6v3MMPGEe8s5ESn7j9Q5GRrM2Stxl58zMjwA5b4jtzHtAwTojiQoXQDVPR8zfIjVq8w8VoR
 f1dRyu4qxJKuFulaLEk5C+QxHpbKmpiqwT7epnSCvMZO9eoBSN7LlmQysL26NMa66MqZ8j62j
 1P17XPAQ9SUXoTx/ofVTlE5Rtq0devt04FVIElobsytlDZWha+1YtZswy+tHcJXFFvLfrLYj9
 jrPAlqgI6zhrL4PfNuYnRL4P5WlOVwMrDSJEISOSFlF4X4bctMt+Px3O/wM4qD
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/18 7:16 PM, tip-bot for Heinrich Schuchardt wrote:
> Commit-ID:  793423cf07e51e3185b8680167115813589c057d
> Gitweb:     https://git.kernel.org/tip/793423cf07e51e3185b8680167115813589c057d
> Author:     Heinrich Schuchardt <xypron.glpk@gmx.de>
> AuthorDate: Mon, 17 Dec 2018 19:02:14 +0100
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Mon, 17 Dec 2018 19:12:48 +0100
> 
> efi: Align 'efi_guid_t' to 64 bits
> 
> The UEFI Specification Version 2.7 Errata A defines:
> 
>   "EFI_GUID
>   128-bit buffer containing a unique identifier value.
>   Unless otherwise specified, aligned on a 64-bit boundary."
> 
> Before this patch efi_guid_t was only 8-bit aligned.
> 
> Note that this could potentially trigger alignment faults during
> EFI runtime services calls on 32-bit ARM, given that it does not
> permit load/store double or load/store multiple instructions to
> operate on memory addresses that are not 32-bit aligned.
> 
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: <stable@vger.kernel.org> # v4.9+, or earlier if possible
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Qian Cai <cai@gmx.us>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-efi@vger.kernel.org
> Link: http://lkml.kernel.org/r/20181217180214.9436-3-ard.biesheuvel@linaro.org
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  include/linux/efi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 100ce4a4aff6..e6480c805932 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -48,7 +48,7 @@ typedef u16 efi_char16_t;		/* UNICODE character */
>  typedef u64 efi_physical_addr_t;
>  typedef void *efi_handle_t;
>  
> -typedef guid_t efi_guid_t;
> +	
>  
>  #define EFI_GUID(a,b,c,d0,d1,d2,d3,d4,d5,d6,d7) \
>  	GUID_INIT(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)
> 

Before rushing this patch in, we should carefully review its side
effects, e.g. on 32bit system this changes the size of
efi_config_table_32_t from 20 to 24, which is part of the interface to
the UEFI firmware.

Best regards

Heinrich
