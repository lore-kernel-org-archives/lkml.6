Return-Path: <christophe.leroy@c-s.fr>
X-Google-Smtp-Source: AH8x224GzfYXKaIakyzu3Sf90cRAOWVipur6bpjeQ+8gxGxELSzVWDtcLwWj7F1z1RR1rKzjXgS/
ARC-Seal: i=1; a=rsa-sha256; t=1519235625; cv=none;
        d=google.com; s=arc-20160816;
        b=PKM9iBLNU0e/iYviTW4M+SNuM2e6KCU0qDO/DXkC5INn4sSdIvffnWxQSG6e/gnCs0
         /BYgjvP1BUItx4kMtbWQMkiBIvvu+BQvL/e2zQI9adNjDIdi1egyQw7ldbaJ5TaIb61X
         FhGWcTifTd9cw/rJaDKe9B1UrUsNeeOW/jei0ykTd4bxJKSF6mPhaWA4WOeteJ62Q9le
         YwjZRdxOxpZbWegbk1I+Y8wpW1kSsjpB9ulJLEhgfNkJ9CKhI4PIN10W2INxPrtym/T5
         kdNphZwrefr5sBnlUDElLOifFwV9vTPm46CH3ENPp4b/5JLd2eHmEuaAjWh3lxXMAmXr
         5JzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=r6X3xrmkLKnzMiSllkRzsNCcuSuwM8L6rsg6tASQLHg=;
        b=0uyWkoA9KfbA3ZymrAdavTOvB//9g3xJZF9jd+QL1PfAuTxlhLdZyAuqVxL1ZOsm50
         20+jZ0EhjP/NC9+EbOQHRvVTURX4HRsoGieMOCiVyt7z7nJAqAVBF95nGu0LvcezN5Ax
         +bWOMkePIC/QPU8BR4ZjPAVWgpAq6eU8utxOvEVhWlFn3gIq2C4gGzUsawm6g1F4R2ND
         ToJ6kOPAtXqVHi/4dXPLJbd9z5tLygvO3S6qDhdQh22voNZJPiNX2L0yc0adfetgNW3q
         ws8FKRy4LiE+o8EH+EU3QYIARntsn2RsEQDtpsVwhEfdrN7vuhueNUm8dX2m3yQFfZ7E
         qjAA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of christophe.leroy@c-s.fr designates 93.17.236.30 as permitted sender) smtp.mailfrom=christophe.leroy@c-s.fr
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of christophe.leroy@c-s.fr designates 93.17.236.30 as permitted sender) smtp.mailfrom=christophe.leroy@c-s.fr
Subject: Re: [PATCH 5/6] powerpc: Implement DISCONTIGMEM and allow selection
 on PPC32
To: =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
 Kees Cook <keescook@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, kbuild-all@01.org,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Joel Stanley <joel@jms.id.au>
References: <20180220161424.5421-6-j.neuschaefer@gmx.net>
 <201802210756.OZokd64C%fengguang.wu@intel.com>
 <20180221160815.dxhpsejt74zeqqjd@latitude>
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <a0c7806e-e06e-eb6c-416b-022bdc36d757@c-s.fr>
Date: Wed, 21 Feb 2018 18:53:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180221160815.dxhpsejt74zeqqjd@latitude>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592937314761110102?=
X-GMAIL-MSGID: =?utf-8?q?1593034015717742443?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



Le 21/02/2018 à 17:08, Jonathan Neuschäfer a écrit :
> On Wed, Feb 21, 2018 at 07:46:28AM +0800, kbuild test robot wrote:
> [...]
>>>> include/linux/mmzone.h:1239:19: error: conflicting types for 'pfn_valid'
>>      static inline int pfn_valid(unsigned long pfn)
>>                        ^~~~~~~~~
>>     In file included from include/linux/mmzone.h:912:0,
>>                      from include/linux/gfp.h:6,
>>                      from include/linux/mm.h:10,
>>                      from include/linux/mman.h:5,
>>                      from arch/powerpc/kernel/asm-offsets.c:22:
>>     arch/powerpc/include/asm/mmzone.h:40:19: note: previous definition of 'pfn_valid' was here
>>      static inline int pfn_valid(int pfn)
>>                        ^~~~~~~~~
>>     make[2]: *** [arch/powerpc/kernel/asm-offsets.s] Error 1
>>     make[2]: Target '__build' not remade because of errors.
>>     make[1]: *** [prepare0] Error 2
>>     make[1]: Target 'prepare' not remade because of errors.
>>     make: *** [sub-make] Error 2
> 
> Oops, I'll fix this in the next version (and compile-test on ppc64...).
> 
> Weirdly enough, x86-32 and parisc define pfn_valid with an int
> parameter, too (both of them since the Beginning Of Time, aka.
> v2.6.12-rc2).
> 

Behind the fact that the pfn type is different, my understanding is that 
you have to define CONFIG_HAVE_ARCH_PFN_VALID in the Kconfig in order to 
avoid it being included in include/linux/mmzone.h

Christophe

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
