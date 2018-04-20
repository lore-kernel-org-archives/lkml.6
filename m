Return-Path: <dave.hansen@linux.intel.com>
X-Google-Smtp-Source: AIpwx4+EWeBu641sA9NKqGaFgRCKcmDjlj6AOr+oyGXnybi6ExcHkR1nCSL1RacP76KvMLN/6v/M
ARC-Seal: i=1; a=rsa-sha256; t=1524253488; cv=none;
        d=google.com; s=arc-20160816;
        b=XAUPH0WtTsQ09KEBN3ilbL+Rfjnz5hqAD9eRBJdheMyhJ9j1furxDJupzK6hIwGX8b
         uXoG+wstU81NVP9Ep+9iMPvArHowc0VHhAHnteoQkhPxn+TkdZshHewc57Y02Q8w08MD
         Qdh4dvuiMUm2EWdz6LgUGF6QyX2eWjpOEF0g0feP4dKR2JPwWKeEAN/p3e7RTdN5adJS
         ph9TwxTxTotvnHxkCVtevCZMlbi4/YrolYIl4r2tvrtz4/OeOKwYCAfQE0JFXY7/BkMh
         TheBNBr5zZO4sJyjc2wS6ziS6+hb0fLyzyMfWOS5BhME6hLqdM8engwQL6fEnRfkLtPK
         11/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:cc:references:to:subject
         :arc-authentication-results;
        bh=VuA08VKk7bMIfmsaqdyJNTYkYVKHaKOeeIqFJeUOCqA=;
        b=mj/Cz0gdM4EasCfQMdzTDioai5G7RAy3iUD8qlh3j5LvmXPgPr0wL7UQIxtoWgSeY0
         QdQyNM0GnVxx66u8qM/reGSPiLTdVu6DjSme2F27jan87x8/NemtFi10NS6tZKUvwsqi
         /J460eJr4XA3Drvd+mGBsSf5hZGEZYr0hZesqMWAoLu9xSLvJO/1ldW31zrevXdwswdB
         8MYPgISrJ/nYOHj5ACuqE2Wn2WBgHCUICETBXA1NTokfoE6uvfF4uRNHuFKG8UlGA2Ge
         VOmsfjE+Efdo+qkTWMUCg8wJCpsZVll0HYeq4nUEzmAwrAgAl/N9vwNkxkeWt+Y5GqF3
         3ZVQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,302,1520924400";
   d="scan'208";a="193134236"
Subject: Re: [PATCH 2/2] x86, pti: fix boot warning from Global-bit setting
To: Thomas Gleixner <tglx@linutronix.de>
References: <20180417211302.421F6442@viggo.jf.intel.com>
 <20180417211304.7B3F1FDB@viggo.jf.intel.com>
 <alpine.DEB.2.21.1804201215170.1683@nanos.tec.linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, mceier@gmail.com,
 aaro.koskinen@nokia.com, aarcange@redhat.com, luto@kernel.org,
 arjan@linux.intel.com, bp@alien8.de, dan.j.williams@intel.com,
 dwmw2@infradead.org, gregkh@linuxfoundation.org, hughd@google.com,
 jpoimboe@redhat.com, jgross@suse.com, keescook@google.com,
 torvalds@linux-foundation.org, namit@vmware.com, peterz@infradead.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <df7f4b2c-9048-19f5-4817-45d29eec022c@linux.intel.com>
Date: Fri, 20 Apr 2018 12:44:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1804201215170.1683@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598029619129049046?=
X-GMAIL-MSGID: =?utf-8?q?1598295625596706589?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/20/2018 03:16 AM, Thomas Gleixner wrote:
>> pageattr.c is not friendly when it encounters empty (zero) PTEs.  The
>> kernel linear map is exempt from these checks, but kernel text is not.
>> This patch adds the code to also exempt kernel text from these checks.
> Bah. Changelogs should tell the WHY and not the WHAT
> 
>> The proximate cause of these warnings was most likely an __init area
>> that spanned a 2MB page boundary that resulted in a "zero" PMD.
> This doesn't make any sense at all. 

I've rewritten these changelogs and added some more fixes for this set.
I'll be sending it shortly.
