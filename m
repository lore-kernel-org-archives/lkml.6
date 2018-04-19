Return-Path: <gustavo@embeddedor.com>
X-Google-Smtp-Source: AIpwx49ZKAndzdojbsQkfdpRAXqgXbvbJ+aQv6ycyUUYLr/b0Qwi0aNIDDvRHk27lIlRxHaO4dBK
ARC-Seal: i=1; a=rsa-sha256; t=1524146302; cv=none;
        d=google.com; s=arc-20160816;
        b=HIpuzfSYe7LjuogR7q3hRg3GJowaa44gxxUyxtf22+YVpzb/G4ySqfeDbC/KGB0c5h
         IQrA0uglkyI1vFHI4IHfDGxyU2QtpXu/yEnaf3Tieb+0SW20iuKiaiXQWEcRnXaBV5D0
         BvDe0KBKZD4FtjLGD1PskMzwQouc/FBZn5Z/CDXeaHNShaWWCjXk3v+a8w+NBkUAmFWo
         n2WmjhdQVQ6uojm2hMKB2nWIJzhc9xlLqDKfU4JvyVWMh4Om6XLIOxJ/pjp1xRllpLZu
         2i28B89JQXPSofrj0yCl/vvBPSN++qpzB6BIUt+OQCWixIaU2ycZ89ffwkuVgSzuvDjg
         OLGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=Qhk7QWzUphxMdjbq5i4J/NgE6YLfI58PPjO8awHDT+g=;
        b=YJLNe8p8C0Xm+xFf99i1wc+T7nZiTYb8Im9hQjBg8EzpSONOhS/2UQjvpw/Nr3jy4P
         hPe99alpp+rwsCV66HuqDxTPHB+VdGW9HjcM0zULUZ5tbDSYhbsCX8PWO/rA3cHjm3ts
         moEK/XuHPLAB11c5ZA5rhg4/NQNOmnKLHCKV4kL+Lx7OtFZc6V/jNQcisitKJegXvwWq
         +t0GASZ/CzRrt87DIDhOKPVMkrH3uJGhScBnvxrhk4TfeAmg2nbWTcUuNpIGumj2Dzx+
         1VtBzttIYmvPLiZPTY9V9EqbN1D5zMDbaqBr+sGWnnKNon/+RaegfhtlafrHtTUIq565
         OcHQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of gustavo@embeddedor.com designates 192.185.188.18 as permitted sender) smtp.mailfrom=gustavo@embeddedor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of gustavo@embeddedor.com designates 192.185.188.18 as permitted sender) smtp.mailfrom=gustavo@embeddedor.com
X-Authority-Reason: nr=8
Subject: Re: [PATCH] ipmi_ssif: Fix uninitialized variable issue
To: minyard@acm.org, Corey Minyard <cminyard@mvista.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20180419132429.GA13997@embeddedor.com>
 <738f2ba2-b0db-9120-4590-eade830dde25@acm.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <37e1ee2c-8dd6-9286-475b-a853cae77a3e@embeddedor.com>
Date: Thu, 19 Apr 2018 08:58:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <738f2ba2-b0db-9120-4590-eade830dde25@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - linuxfoundation.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.6.211
X-Source-L: No
X-Exim-ID: 1f9A4r-001iTN-LB
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.71]) [189.175.6.211]:49550
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 14
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598181106409658883?=
X-GMAIL-MSGID: =?utf-8?q?1598183233114815219?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 04/19/2018 08:40 AM, Corey Minyard wrote:
> On 04/19/2018 08:24 AM, Gustavo A. R. Silva wrote:
>> Currently, function ssif_remove returns _rv_, which is a variable that
>> is never initialized.
>>
>> Fix this by removing variable _rv_ and return 0 instead.
> 
> This fix is in my next tree now, thanks for catching this before it got 
> any further than that.
> 

Glad to help. :)

Thanks
--
Gustavo
