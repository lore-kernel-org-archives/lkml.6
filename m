Return-Path: <nick.lowe@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518800216; cv=none;
        d=google.com; s=arc-20160816;
        b=iY6RrB+PaoXOKA4n0Yji8xbzUJQ69s1khlX1g+McUTbJsZ/og7TwTyOl/dfsjgXlMa
         7rhlTSJCBJC1psrCVVPty2XUfPjsIbyIAnr+ES9Vdk704uUUY3Tez3b14sf512aLlWCU
         iOU1b6iIYJM5gJ3zZc4wxadgb4Pe/hvDPMS2qxhHLc7mm5SC884WdMGXHFOqBffIds3h
         BQJVdEV8Yc501YvRnygjZNY07lSBDMTcizBh5vD8eSoOef9RV27aWFszv7qfS4nXeAV5
         lFLvZds6ei2rUhDVgQtjjoEB8RQlc83Al0JtCNLB7MWAq3DGdyMtxyuFiJv+TwyNYm0t
         jXQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=Z77OIW/81kM5xtxl2hJKSVojYdBAMxj6cVZfUStKDCA=;
        b=ccYYUshB6SBR8tS5j/yNJA4hN4Tac9A2l8CvEL3a/1Kd4Oz8Tivn/pGqrhFnTZej+m
         ZHamrc2R+ZfE+FySXCit/fOpDypy6OvDnh3RI/WBAqcE8Y7geFtE/fv9g8W2wyX7Llm4
         /AbOIvffAbNFqyjqTZaaGFeyKQt7uwJ2UNbvTNYQNfoM1Q6oJrVynCyq2sOBstPvsM29
         J0emFFcQ2tyWpJkPsMoNVpKgexUxltVa2kEH9NkvEmD4kq5HGG/5mZP2QQhmzHvT4aEu
         WSAvct3zfBb4/5tFuUPgMLKRfAJ0B6LZMTcN7zImrTGfeEzfTSv0PY6natlG/hBAXAJz
         61ww==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fXp9XCfP;
       spf=pass (google.com: domain of nick.lowe@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=nick.lowe@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fXp9XCfP;
       spf=pass (google.com: domain of nick.lowe@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=nick.lowe@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x224eWS7hnH8EgjLwG5H9m8hCJ5Nsq4M9wcFVBmoA1/t6SWRA2X/4hwKqbwQtfX38RiMwHE9hApohy9Qzrgq6mj0=
MIME-Version: 1.0
In-Reply-To: <CADSoG1uW5PuT9dr+w3npf6LiLvBL5=2x=uN98+JVNTR3KQbH5w@mail.gmail.com>
References: <20180209133931.211869118@linuxfoundation.org> <20180209133934.259299920@linuxfoundation.org>
 <CADSoG1tjU2G9FUNOFod4ZsYSw7gOSsza_JWUv5H6pAkbftWywA@mail.gmail.com>
 <20180213150007.GJ26982@kroah.com> <b0680083-5cd2-e152-0d64-f5a931274a8e@linux.intel.com>
 <CADSoG1sv4-YmRh8AwD7A93_eDLn4ZTwD0Y7C9jyRyh6nOvwqjQ@mail.gmail.com>
 <20180213163239.GA17101@kroah.com> <CADSoG1uW5PuT9dr+w3npf6LiLvBL5=2x=uN98+JVNTR3KQbH5w@mail.gmail.com>
From: Nick Lowe <nick.lowe@gmail.com>
Date: Fri, 16 Feb 2018 16:56:54 +0000
Message-ID: <CADSoG1vtapcUq42akvdHzGS73MBuMYoWH7m-YiK0X2SBoBcYvQ@mail.gmail.com>
Subject: Re: [PATCH 4.9 43/92] x86/pti: Do not enable PTI on CPUs which are
 not vulnerable to Meltdown
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>,
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>, Dave Hansen <dave.hansen@intel.com>,
	gnomes@lxorguk.ukuu.org.uk, ak@linux.intel.com, ashok.raj@intel.com,
	karahmed@amazon.de, torvalds@linux-foundation.org, peterz@infradead.org,
	Borislav Petkov <bp@alien8.de>, pbonzini@redhat.com, tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591931030693871871?=
X-GMAIL-MSGID: =?utf-8?q?1592577455507731182?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

This should use boot_cpu_has_bug(X86_BUG_CPU_MELTDOWN)) - I am
preparing patches.

Best,

Nick
