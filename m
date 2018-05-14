Return-Path: <mingo.kernel.org@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526290236; cv=none;
        d=google.com; s=arc-20160816;
        b=leXbpG3fyKqpgYw3a5NTknIhuMuv0lm7hvwj3Gv+8N0Mj9u0znItjxnZrisKDO1A7G
         R+LauB6/l4e4D0VuOoDz2JZsq1N0LUgt+Imvdzqe4jAYtwN5e97j5bBsDPhk9NLn03At
         cSj+1ItTsnRsXW8rw/LGMhMKQwJz8gdKpOfb14ftGpeI7foCNs16ROB7KueQFOaoRvWg
         8BTZpw3HayvGG2Ifkxz34zLOaOzih8zBdaG248XgXMsz3ZmcYQWlH+7/D1J5ANpYI1Ez
         V1+o9rUga1UWALZXBE2RCYIEiLMu2mgA8dlppDgCG4FDhHH3bJ1jTSTVMwjAvuEDC5on
         +wEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:date:from:dkim-signature
         :arc-authentication-results;
        bh=/4s5c8ce3WzU88C0zjJ56FZI5YWXNE98zk4tAQxz/lI=;
        b=aChr4RYEFCmvm7jvmMLxqCT1MnrdpmSyEp+8UrVg/EilEZ28HYhELgiZxlTGps1WId
         PGETL5Gh001BfJ2gS8quHW32DhAaLXr3TIpUYLOmwA4aTxDfnYzx5bmG/Ljk+XGZBxo8
         GURHqLj2vEbGMvus9H3kKiCgmJ0IkVsGFhygOf/ymEHLlyaNg5GEzTn/45ST8Vvt9C6h
         xx1p+O9pOSnYgFV8rJchfX4xqbSUIIJdfFRXG5DrtFHNYa3DAXVPzWCsvWZSe2e8IrcJ
         VCbSNaW9gA4/kZWDR3pu3GxzZr66eCe+jV8pLmxrR2K3xdHR1ymZGbYyCLwJraTkUo7C
         Kw/g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=E6ao5eTX;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=E6ao5eTX;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZpk99488qF5qoB7JvfuFEm3hPTQ9BftPHhYCh6q5Vt/wVTKafLKyj+IwnsE3/pIMUXW8Fl2AA==
From: Ingo Molnar <mingo.kernel.org@gmail.com>
X-Google-Original-From: Ingo Molnar <mingo@kernel.org>
Date: Mon, 14 May 2018 11:30:15 +0200
To: Dave Hansen <dave.hansen@intel.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, tglx@linutronix.de,
	gregkh@linuxfoundation.org, pombredanne@nexb.com,
	ebiederm@xmission.com, luto@kernel.org,
	linux-kernel@vger.kernel.org, philip.li@intel.com,
	leist.fnst@cn.fujitsu.com, zhijianx.li@intel.com
Subject: Re: [PATCH 2/2] tools/testing/selftests/x86: fix error: conflicting
 types for 'pkey_get|pkey_set'
Message-ID: <20180514093015.GA27428@gmail.com>
References: <1525770870-19067-1-git-send-email-lizhijian@cn.fujitsu.com>
 <1525770870-19067-2-git-send-email-lizhijian@cn.fujitsu.com>
 <125eb810-1d48-394d-9665-40da64326fbb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <125eb810-1d48-394d-9665-40da64326fbb@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599886734480796496?=
X-GMAIL-MSGID: =?utf-8?q?1600431310693278777?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Dave Hansen <dave.hansen@intel.com> wrote:

> On 05/08/2018 02:14 AM, Li Zhijian wrote:
> > -u32 pkey_get(int pkey, unsigned long flags)
> > +u32 _pkey_get(int pkey, unsigned long flags)
> >  {
> >  	u32 mask = (PKEY_DISABLE_ACCESS|PKEY_DISABLE_WRITE);
> >  	u32 pkru = __rdpkru();
> > @@ -422,7 +426,7 @@ u32 pkey_get(int pkey, unsigned long flags)
> >  	return masked_pkru;
> >  }
> 
> I'm not a huge fan of random underscores for undocumented reasons.  But,
> oh well.
> 
> Acked-by: Dave Hansen <dave.hansen@intel.com>

So I saw these too late, fixed them already, and did it slightly differently:
I used a hw_*() prefix which I think is cleaner and more obvious than underscores.

Thanks,

	Ingo
