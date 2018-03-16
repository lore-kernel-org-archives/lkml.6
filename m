Return-Path: <kernel-hardening-return-12666-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELu/GWC6TcVSavLyPbZnExMVQXtcGNtg79nhvaalLgTpFGYv8fvTteTJlbfX2GnTw4FUQjlS
ARC-Seal: i=1; a=rsa-sha256; t=1521221546; cv=none;
        d=google.com; s=arc-20160816;
        b=rBhgcRK4h7xBEhuhSr8hO82kiQOrOruwCA77a1LeYrqIhNXagz7JLfCb2+fCzuCfPb
         46NMb6lYb7Y/FUt7yWKH14WiASAp1O52GMzIjw0dAaXNKB3Zb8K1a2OG151gfmkLkKwX
         LuLDNB3xfSQKyQzQgTSSJ57YKY3UUCSoM4mQ8gqzbtQE+em62u8Wa+8ZXt3wqHIbSwuC
         wmnhcuJ6t7FeFHYgCDKHMK6PW5efF1WCqE9//X6hJXLvR08K9CbdUFlyJeY6YZnoJgaP
         DzIORIcGzUfTSEK4e0dN7m+2wQp6RQ/mo1ocrQTcF+wd+Z8ZlxPItPtr3yXdUqM5xnjL
         eUjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=gV3g5gCSVfvVDraoEHrp9hJFA7Yy0Ue+BkzixFi2Dzc=;
        b=WSsIEuRgP+5XXxHPpQ+9flYlgbV4YZmwn+NInOuhoAVJV/mHYXPXfWQpT1tN6pS8RR
         LvV8h1HmzaamZR1T3JCKAJdvVAmv9B5bfnkH1sOu9OeYvwkpuwRAhOCf49EWKBeb53wD
         X7T/JClXoOCIwX+W3OH8Op9/CyPM6CiznU5Ipaat3AQ9EyZWUiYsa9heBesZdQpHIJvX
         A1y7MhnDgTu9EAGOij3C4C7t+yZHlk5pGFw5HBQXDOhp+9fDYrmRDLRb4kXW1ruOPZku
         N0RNhdW+adILDaVDorr8/uIjW42ZIkZbMvp/uWs7atnWWg33vK93A5V/bpkpZUx/oJZx
         9Reg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12666-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12666-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12666-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12666-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH v5 0/2] Remove false-positive VLAs when using max()
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Randy Dunlap <rdunlap@infradead.org>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Ingo Molnar <mingo@kernel.org>, David Laight <David.Laight@aculab.com>,
 Ian Abbott <abbotti@mev.co.uk>, linux-input <linux-input@vger.kernel.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>
References: <1521174359-46392-1-git-send-email-keescook@chromium.org>
 <ab2933a2-ca7b-eb3b-744d-bc037b1be688@redhat.com>
 <CA+55aFx92dXg-qnrjGS2Rsna6TE5HSPBgGpSA3cv4n_n3RqBzA@mail.gmail.com>
From: Florian Weimer <fweimer@redhat.com>
Message-ID: <707292bf-b69d-8d25-b70d-dda0a23e1c04@redhat.com>
Date: Fri, 16 Mar 2018 18:32:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFx92dXg-qnrjGS2Rsna6TE5HSPBgGpSA3cv4n_n3RqBzA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595034368078500739?=
X-GMAIL-MSGID: =?utf-8?q?1595116404241515590?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/16/2018 06:29 PM, Linus Torvalds wrote:

> Gcc people are crazy.

End of discussion from me.  This is not acceptable.

Florian
