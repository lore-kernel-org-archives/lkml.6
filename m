Return-Path: <kernel-hardening-return-12715-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuzcqHWwN3Ono+tCBfd/jmHeEF1WghVELZosQJmmD5cY3w/CY8PGSytwRDH+zospk1YWUCb
ARC-Seal: i=1; a=rsa-sha256; t=1521640309; cv=none;
        d=google.com; s=arc-20160816;
        b=IkRXhW6vihd23PZqbVSV5bp6mgdr7IKZ5/Thi3tA/ttnwgXccuAG7SaLSpysLJk7UZ
         0dPNZQ2HPfdZ/bYdP4Az2FBeFjpPGpq94nYz2Dgb2wCNGPdiffR4Ig8sbnk6Jxa6L+nv
         iOjZRi8XAvD1wsyneGHRwJI6TssmZdkbt64yfZnjnQeENFoFkyvkGoi+vmUkjzQpZgOW
         Anq71rjFyi9+4Rc6LoUQ4fwbhkcKunnzGhjUIhIXBQPNLN13PEOy4ozI6Mto1zD/A57x
         o4aBXl1UFN5qEpHhrwMiAL89QYEVyxivf7BTR12iVMOhRwJSALG4ODdg+v5F1cYzS/A1
         sGfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=ys9Y09a6tFmtx0pQyesSCcObB2n/rzLSDob/qyomNKc=;
        b=0HtAOn7Be1Ltlv/aWJlcWFsvXKaKHj2J88rwZ5YU75VlGX2zFa7Ryov9uZD40nbCUh
         uGHbxegWtLe8WzSGOAa4skIIznouZsMh9qAI3sazaO9zt4yrH+iGC0A/WxO4hwhc0o7h
         rwf/71y9bs2vzxIwZgFTXHcSvS/1ltn05ltA8Fv0xyGQrg8nDRDA/f/uQQyjp8s495Cg
         7CUjk9h4fjyZBUjc5zEQ/dcxXMvlL7hCdFnCojKA+8lOoGUCWY+/QDIcZ6m9IA0cKAVW
         dq3IlozRYIubDvXna5XvExkaDgYnozdvoY+tIppYv6AIdFBZnGIP//s8qnai4kkzxMp9
         uPOQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12715-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12715-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12715-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12715-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH] netfilter: nfnetlink_cthelper: Remove VLA usage
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
 Florian Westphal <fw@strlen.de>, "David S. Miller" <davem@davemloft.net>,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kernel Hardening <kernel-hardening@lists.openwall.com>,
 Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <garsilva@embeddedor.com>
References: <20180313002138.GA27280@embeddedgus>
 <20180320123655.kugtpftt7nhzvqc5@salvia>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <1794f439-684a-b2ca-2b89-a15c6b6dcd30@embeddedor.com>
Date: Wed, 21 Mar 2018 08:51:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180320123655.kugtpftt7nhzvqc5@salvia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.openwall.com
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.145.54.187
X-Source-L: No
X-Exim-ID: 1eye9I-000Qiz-AP
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.67]) [189.145.54.187]:45316
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 20
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594779782164059647?=
X-GMAIL-MSGID: =?utf-8?q?1595555508462512714?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/20/2018 07:36 AM, Pablo Neira Ayuso wrote:
> On Mon, Mar 12, 2018 at 07:21:38PM -0500, Gustavo A. R. Silva wrote:
>> In preparation to enabling -Wvla, remove VLA and replace it
>> with dynamic memory allocation.
>>
>>  From a security viewpoint, the use of Variable Length Arrays can be
>> a vector for stack overflow attacks. Also, in general, as the code
>> evolves it is easy to lose track of how big a VLA can get. Thus, we
>> can end up having segfaults that are hard to debug.
>>
>> Also, fixed as part of the directive to remove all VLAs from
>> the kernel: https://lkml.org/lkml/2018/3/7/621
> 
> also applied, thanks.
> 

Awesome.

Thanks, Pablo.
--
Gustavo
