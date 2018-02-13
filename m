Return-Path: <arjan@linux.intel.com>
X-Google-Smtp-Source: AH8x2266Aic5ClIUhzgGnOubwujSsbs4SQ3OYDUXjrKCXCuJ9AOJAWZxsVpIq0bejSRCXEAqmIul
ARC-Seal: i=1; a=rsa-sha256; t=1518534588; cv=none;
        d=google.com; s=arc-20160816;
        b=fDyra8xElBjNU4LvyZ735kYh5Kfjq2LxfLDiFOw3v8EU6lvX20rnCCjdMv9opN4J0a
         BdMxiOYqRRMPYhlIWgQABu1ANZo2ADpz/m3S/L2IvJez1FFYe63D4tefaJz2w+8f+MYE
         IvUYPGUawI+gr/GrR/3tHkPJEeOOnVrXRATbKkW7z+9Fx7fAKaGlmSbxB8K85oqEWL+U
         4Z52ADYBWrduNYvP0ztzq5NtvzVUkGgEf9Nqlyvk9Ca6Uj29Q1a+EuYVmo3gFurMOO0N
         db6KEUtlIya+VLPB1Zq+DTVdcNIGmrLmsblVag71YALWZ6EZX5w8cWGk6yP91qoJuxQR
         LwaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=kkMhPtbiSGoy/eUKNBoOph73w3Pli+N5pNUAXNfMztM=;
        b=OTs9uzB8Y92vM0unnmFbrcUPojHtpfQt8Dqwui4OKj3/Jb5gIAawClAaT50MqmUSPx
         iKM4/tF8W+s8URQZApBfF8wbT0T4K4j13IRfzqXrN+NrJZhpWu29dlbXA/lZIy4umEAi
         M+JOS9bigc7mpHRs3X4TfjlxSDPQCJchS5tcxRoW24TVpzkh1oURu9/tQjHtzFCLnUof
         brhZ/AWKYkAubUHMGxtoqCYl8k6RtqDrg69auMadQTwRBTizywbWeKusN1AIqv4pts6i
         HWLKaQbSKXBRV86dUOO0doKbOoEXf1M7LK1/WfQl4Nlcee5jaCB1Fb1KQn0+cgtlGQJ+
         SkSg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of arjan@linux.intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=arjan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of arjan@linux.intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=arjan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,507,1511856000";
   d="scan'208";a="17391696"
Subject: Re: [PATCH 4.9 43/92] x86/pti: Do not enable PTI on CPUs which are
 not vulnerable to Meltdown
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nick Lowe <nick.lowe@gmail.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 David Woodhouse <dwmw@amazon.co.uk>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@suse.de>, Dave Hansen <dave.hansen@intel.com>,
 gnomes@lxorguk.ukuu.org.uk, ak@linux.intel.com, ashok.raj@intel.com,
 karahmed@amazon.de, torvalds@linux-foundation.org, peterz@infradead.org,
 Borislav Petkov <bp@alien8.de>, pbonzini@redhat.com,
 tim.c.chen@linux.intel.com
References: <20180209133931.211869118@linuxfoundation.org>
 <20180209133934.259299920@linuxfoundation.org>
 <CADSoG1tjU2G9FUNOFod4ZsYSw7gOSsza_JWUv5H6pAkbftWywA@mail.gmail.com>
 <20180213150007.GJ26982@kroah.com>
From: Arjan van de Ven <arjan@linux.intel.com>
Message-ID: <b0680083-5cd2-e152-0d64-f5a931274a8e@linux.intel.com>
Date: Tue, 13 Feb 2018 07:09:44 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180213150007.GJ26982@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591931030693871871?=
X-GMAIL-MSGID: =?utf-8?q?1592298924989294855?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> 
> So, any hints on what you think should be the correct fix here?

the patch sure looks correct to me, it now has a nice table for CPU IDs
including all of AMD (and soon hopefully the existing Intel ones that are not exposed to meltdown)
