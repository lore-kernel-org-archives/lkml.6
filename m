Return-Path: <kernel-hardening-return-13226-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZoEa+o1jpqSjuQcrFoplaQAX+M0oMI8XDRhqz5vg5Q0sUV3njTYET2gpzclT2oqXXbIirZk
ARC-Seal: i=1; a=rsa-sha256; t=1525544562; cv=none;
        d=google.com; s=arc-20160816;
        b=S0J6lXksaGdfWV7Na+Z2V3eytg3RyTv5L8nL1X7k100RgMzrpmdgmqifNxLWSk2dQN
         n438htxSUWIrnprNSKZusba6guWnKzOdql5RStE/nuduDLO601UKVP043jCFKlu6Jfj0
         +LeRgi2c/koHfzMSUuMru6p6Gngto9IP9rhsCPnooy09yNSonE5ExA4bjxl7aDod6iuV
         9qKgRy7sd6jqx8o4BOk9h2hsLJS3hiNZ38fOVwLQninNwN2rQSlELuWbOKBgw6ukp7wq
         T9OsgtiFAAfZf2t7IFsWJKvPMLWl+QkXjGWme97H0b/Uotb32l1bip2HhYvdZAoyhcd9
         +n/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=S64+5UISbcQpFT1e4a2+SrX8iZVSo22CjhCPe1KMOWo=;
        b=Dpwq8S6g26T6eT3OZlhXHV5+rsU//j5UceOtE+OILMULBNOZS/NuFr3k72csoxAW8J
         CId6cY/U+XNNWmChCq3lajH2pyQNORQU3cy2EmajGwVu0XKG+EiLy7UV7+D088YrBlBx
         jhCqrWxXcaQniRJxrTo+p13edQfV8Ln87A451FWXLjMhPTZIS1GsMd2eP2DqeuvAO8SA
         dPcYSO4CeCXqw3jF4t7wtpuFSrnokATarwSfp+RbnUjM+lIMdLu3Hn/EJVRDZNUj+etZ
         Ek4O9Nd/cQ+rnNg7kkLbiYDcqBja/RcKBf33B6P6mD1ulb0D44ClHLLFvQa3nFYJYKoc
         Wq8Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=S20BT5vg;
       dkim=pass header.i=@chromium.org header.s=google header.b=bVhUPcO7;
       spf=pass (google.com: domain of kernel-hardening-return-13226-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13226-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=S20BT5vg;
       dkim=pass header.i=@chromium.org header.s=google header.b=bVhUPcO7;
       spf=pass (google.com: domain of kernel-hardening-return-13226-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13226-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180505153905.GA30439@lunn.ch>
References: <1520970647-19587-1-git-send-email-s.mesoraca16@gmail.com>
 <87fu5321du.fsf@weeman.i-did-not-set--mail-host-address--so-tickle-me>
 <b948ef55-8b16-fee4-b22f-4c6d09fea0cf@gmail.com> <CAJHCu1+V+khxvzhQdG=mo960b5ayiQcSaoMnm9A__51JdWkdig@mail.gmail.com>
 <20180505153905.GA30439@lunn.ch>
From: Kees Cook <keescook@chromium.org>
Date: Sat, 5 May 2018 11:22:20 -0700
X-Google-Sender-Auth: 8tCujQ65m3yvsB4hcZJOKo3dFIE
Message-ID: <CAGXu5j+x3LU6ADYtvDiXHjw=wws=jjRzmMk9RC4BwWQYWd47bA@mail.gmail.com>
Subject: Re: [PATCH] net: dsa: drop some VLAs in switch.c
To: Andrew Lunn <andrew@lunn.ch>
Cc: Salvatore Mesoraca <s.mesoraca16@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>,
	Vivien Didelot <vivien.didelot@savoirfairelinux.com>, LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	Network Development <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594853343808183482?=
X-GMAIL-MSGID: =?utf-8?q?1599649415140587262?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, May 5, 2018 at 8:39 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> On Sat, May 05, 2018 at 12:36:36PM +0200, Salvatore Mesoraca wrote:
>> 2018-03-13 21:06 GMT+01:00 Florian Fainelli <f.fainelli@gmail.com>:
>> > On 03/13/2018 12:58 PM, Vivien Didelot wrote:
>> >> Hi Salvatore,
>> >>
>> >> Salvatore Mesoraca <s.mesoraca16@gmail.com> writes:
>> >>
>> >>> dsa_switch's num_ports is currently fixed to DSA_MAX_PORTS. So we avoid
>> >>> 2 VLAs[1] by using DSA_MAX_PORTS instead of ds->num_ports.
>> >>>
>> >>> [1] https://lkml.org/lkml/2018/3/7/621
>> >>>
>> >>> Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
>> >>
>> >> NAK.
>> >>
>> >> We are in the process to remove hardcoded limits such as DSA_MAX_PORTS
>> >> and DSA_MAX_SWITCHES, so we have to stick with ds->num_ports.
>> >
>> > Then this means that we need to allocate a bitmap from the heap, which
>> > sounds a bit superfluous and could theoretically fail... not sure which
>> > way is better, but bumping the size to DSA_MAX_PORTS definitively does
>> > help people working on enabling -Wvla.
>>
>> Hi Florian,
>>
>> Should I consider this patch still NAKed or not?
>> Should I resend the patch with some modifications?
>
> Hi Salvatore
>
> We have been removing all uses of DSA_MAX_PORTS. I don't particularly
> like arbitrary limits on how many ports a switch can have, or how many
> switches a board can have.
>
> So i would prefer to not use DSA_MAX_PORTS here.
>
> You could make the bitmap part of the dsa_switch structure. This is
> allocated by dsa_switch_alloc() and is passed the number of ports.
> Doing the allocation there means you don't need to worry about it
> failing in dsa_switch_mdb_add() or dsa_switch_vlan_add().

Are dsa_switch_mdb_add() and dsa_switch_vlan_add() guaranteed to be
single-threaded?

-Kees

-- 
Kees Cook
Pixel Security
