Return-Path: <dave.hansen@linux.intel.com>
X-Google-Smtp-Source: AG47ELskKfC3l+RvXQBPpNQL0Ut1Lnl/BhrvJBjSx11t32ailn7rrBRUFp6t+DgcmNWgzQumU5qD
ARC-Seal: i=1; a=rsa-sha256; t=1520277855; cv=none;
        d=google.com; s=arc-20160816;
        b=n7JsMUuVaT8NAz3ZBmAiKRAzOGhd58BvT7vf264UIdF9erx5nHF7HVicge5Q3Syat7
         ShXmv7QKweNTzHxzuzl0wF5WyHAfAozsQXP0ah81xQkH6yEEWoj/iomjynhZtPZ5Ohm6
         sJvczzB3IbcXR8HNSreRdrHfsbycMEqnGGULW2jOorAm2yNNtg0f4wlxQ5HQZtv8xEyy
         7TsV0TzOMn+pxzsEhRZgq6KQTjgeumoafYZVL8+6/D72Jbf0TBm5xXcbyG8oJcwekjg6
         alzNuyERIzq6upy/wkxIqalFTG9IBdEeSG3kBe9F6/RXMbAKJnVRtgiGCmArwd0UA3Nf
         uNYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:cc:references:to:subject
         :arc-authentication-results;
        bh=BgK4vAT3UTPR04teCd2HCFZgS3jqFsltofvclRsf16M=;
        b=tdWCSZLP/5hari7LI3sQN3BnrnOX8qPuebnFIWWJ38Rt5CZueoSEisOoQu6VaHKVDM
         JEp6V22iNOJDAEnH0WPDncYBA7rEz3oBF6RqiBHkOh6/JG7aBuly/Vc5ULgVtdDzxus/
         5InGojVSy5/SJDAmkSH4W7Qg2VviFMDevtNA4BKfWL2dyY9XRUY7G/m2CXZmbc9ApGrN
         4VPbXa3o3F2ViL1SGRfPO5npdKPZaAGtAm6neXMn+GEpFB8wcp7zFO6wbVlakt/TIMWr
         Q/en/KB9Z58/STQJqi44kPr51TcLJ5zQ+VDmTWsxPff+7DfTUAKZh7joqg0BoogVbrAR
         Tmiw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,428,1515484800";
   d="scan'208";a="32579151"
Subject: Re: [PATCH v12 09/11] mm: Allow arch code to override copy_highpage()
To: Khalid Aziz <khalid.aziz@oracle.com>, akpm@linux-foundation.org,
 davem@davemloft.net
References: <cover.1519227112.git.khalid.aziz@oracle.com>
 <ecbafa2bfcc05f22183be2e7784ed11943b1d5b2.1519227112.git.khalid.aziz@oracle.com>
Cc: kstewart@linuxfoundation.org, pombredanne@nexb.com, tglx@linutronix.de,
 anthony.yznaga@oracle.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 sparclinux@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <68ee1cbc-8e21-e693-7878-777e0d5b0f0c@linux.intel.com>
Date: Mon, 5 Mar 2018 11:24:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <ecbafa2bfcc05f22183be2e7784ed11943b1d5b2.1519227112.git.khalid.aziz@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593031715838543761?=
X-GMAIL-MSGID: =?utf-8?q?1594126872407275476?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/21/2018 09:15 AM, Khalid Aziz wrote:
> +#ifndef __HAVE_ARCH_COPY_HIGHPAGE
> +
>  static inline void copy_highpage(struct page *to, struct page *from)
>  {
>  	char *vfrom, *vto;
> @@ -248,4 +250,6 @@ static inline void copy_highpage(struct page *to, struct page *from)
>  	kunmap_atomic(vfrom);
>  }
>  
> +#endif

I think we prefer that these are CONFIG_* options.
