Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AH8x2271AoLIPxHoqim/5oLsPQnLPZWPhpgRi2/qCO+/NHp6eZNzhOQqzp4frIySHi0zPtNCykWO
ARC-Seal: i=1; a=rsa-sha256; t=1518285927; cv=none;
        d=google.com; s=arc-20160816;
        b=cXpdb2YQkvrTaqU0ZwgFBKdUlDIOtR+QgceikKIk9MPMvxAQf2wo+r8Z8KhS1n3LUh
         DzdajKMq2NEqpZgv0/nxqtPRnTZHF0/+ptMe5dC/G0FUxDOxlQ+4lJ0h371oet/VmWM9
         wCv8rJEUJkdJhIId8tlJu7cRqyi8Z9jqMsNRB5oNhOjgt4sHoT8g5W1e9tQPGXH8M2ru
         xyKqWqoH8n1WN3eGTjmFLDLL8wqGhZrLHwiV3fRTSE2zqxvd7Eq9BaBrpCtA8ZRXinq4
         qOMbWYYdbu1sWC2cmt9jYlBQNPlspnunRNT3q+wrhLh2+qDzQctEUPoM+GBVZ82nbtkV
         Gy/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=98m99iBmw+8bYffH56fzgg8cmj4ix5heOwYb407+UhM=;
        b=t1TBrf6f5/fPVcTL6CvJes/tpvyRKpLR1Cqxs1CP1qnBlUaAaCtKnGt72i4Ayc0PRZ
         ELwuu91QKolerCDP3k3jX7eAIFud6ridCETOEjE0VcMfmWCNvpeQmPVYloUXNHrXDFdK
         +dEDhJqRsf9ingrGvQRnrr9m2TYLf3B+ut3jrVWghykX+rg4qgEGid/hw48Eh6pIIm0X
         z+Xe8lghBQ/oWEivrLH5tUKMHJsysXob6ojavWSUMIZj7+C8z5Flz8oP8eFzW8+rS8Fb
         n7Q+09xqEcIzmjXIdDNLkL8eKU3RamklhAlxUpPWhwdi3htObEUwIq7eGxOu3mpkX2S+
         Pjhg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=ONXXB7Vz;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 65.50.211.133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=ONXXB7Vz;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 65.50.211.133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
To: Ulf Magnusson <ulfalizer@gmail.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Kees Cook <keescook@chromium.org>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Nicolas Pitre <nicolas.pitre@linaro.org>,
 "Luis R . Rodriguez" <mcgrof@suse.com>, Sam Ravnborg <sam@ravnborg.org>,
 Michal Marek <michal.lkml@markovi.net>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, Pavel Machek <pavel@ucw.cz>,
 linux-s390 <linux-s390@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1518106752-29228-1-git-send-email-yamada.masahiro@socionext.com>
 <1518106752-29228-5-git-send-email-yamada.masahiro@socionext.com>
 <20180209053038.pscoijvowmyudyzf@huvuddator>
 <CAK7LNATRxYCx9sE1haw815votyA5K8GQrMPPh0Q+n3kYa=JsgA@mail.gmail.com>
 <20180209124607.akjhncb5sempjqcn@huvuddator>
 <CAGXu5j+hv6G3m+fgr7ibXAnoE-2GsxtXoqr0pd5AaaNdFVQxYg@mail.gmail.com>
 <20180210054843.z3g7wvcmlccvww3h@huvuddator>
 <CAK7LNARHmAF2SxBcc1aUEH5MMzUo_furLevqy7QzGxqNRHYiyQ@mail.gmail.com>
 <20180210074924.3nhxsza5zdbaahxx@huvuddator>
 <20180210080556.mycqsjhxbaguwhay@huvuddator>
 <20180210085519.737ckf4bcl57h4g2@huvuddator>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <246fedb8-d387-5a77-f05d-bf8a91dd6b22@infradead.org>
Date: Sat, 10 Feb 2018 10:05:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180210085519.737ckf4bcl57h4g2@huvuddator>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591850368607646970?=
X-GMAIL-MSGID: =?utf-8?q?1592038184729540393?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/10/2018 12:55 AM, Ulf Magnusson wrote:
> How many compilers don't support -fno-stack-protector by the way?
> 
> 	config CC_HAS_STACKPROTECTOR_STRONG
> 		bool
> 		option shell="$CC -Werror -fstack-protector-strong -c -x c /dev/null"
> 	
> 	config CC_HAS_STACKPROTECTOR_REGULAR
> 		bool
> 		option shell="$CC -Werror -fstack-protector -c -x c /dev/null"
> 	
> 	config CC_HAS_STACKPROTECTOR_NONE
> 		bool
> 		default y
> 		option shell="$CC -Werror -fno-stack-protector -c -x c /dev/null"

I ran:
gcc -Werror -fno-stack-protector -c -x c /dev/null

It worked (gcc (SUSE Linux) 4.8.5) but it did leave a null.o file for me.
Might need to add that to 'make clean' or just rm it immediately.


-- 
~Randy
