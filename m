Return-Path: <jgg@ziepe.ca>
ARC-Seal: i=1; a=rsa-sha256; t=1520866957; cv=none;
        d=google.com; s=arc-20160816;
        b=F2V3SIzbdNOOL9FBt+dFjdblSbOQfLNYWKJ9QqReaZEztFNgIIQ8J3Y/gjDlwM8Zrb
         KOwb+5d3U1C9OVKgEj9Eh6dh9bAPlBtjysPhuWDN98CFgkMk1j241BKTy69MRbeRikUf
         A5l8fmRLWtWky07svsf1NJ6Kfq7AOp+LPDWb1KExvKxhak2AUcH6Ym9N4UHnyE1KP9fI
         t+Wic1FlnEgU8vT0nlnlHo12/ymUq9csPUewd66cZ3GYmCJjxoh6woUrJ5Pxp51XpGwI
         KBrvs0qhvGPWPk66K4LM44OciN465wW1ndAZaWM9WzlFhcBvvSb5DtmO7ezqllnUhqZA
         JDzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=efoCuNbOKoLV8Gfy2nPQZtYW+RfFKk3iJefj4m6SsWM=;
        b=0pUYiCDLW62LuTWw/YTUQcg3xSbgtY1m+aKEllzYE4WWUiObpTj9rlCQbi3sKOebB/
         cIFEbOgD3OJW2NqdngxDwhxsNJ2UXypLP7w6mRC7EX2ZExOw036XITyKXtBzKNiI6Zy1
         ZUO6Ga4dL3mSZCuUuRpqtYw0QVDVmUP1v2FIQvFV0tRexZs7KcT7vRr7/L76wMX/O1G6
         C7COo+lrP7pvAikXtUJyVBQrwsmoNhv9BIxcbNATR0NuV3YMkWBPTUPUx3iuyvwSbZc6
         NfcZLSSPYxYQEltF1Xrwxk7umXCgghQDnKEZNP9UcRFRyHOX3KjdSNyzezxq7tvT+Pcc
         NJxQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ziepe.ca header.s=google header.b=GZI8NEF1;
       spf=pass (google.com: domain of jgg@ziepe.ca designates 209.85.220.41 as permitted sender) smtp.mailfrom=jgg@ziepe.ca
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ziepe.ca header.s=google header.b=GZI8NEF1;
       spf=pass (google.com: domain of jgg@ziepe.ca designates 209.85.220.41 as permitted sender) smtp.mailfrom=jgg@ziepe.ca
X-Google-Smtp-Source: AG47ELviKl7Iu7f/KhYsNFAleYw0bbpr9Y9tSmf9RlrBnmPw09BYQnOAYNYwYvITji4fdJahqwacWw==
Date: Mon, 12 Mar 2018 09:02:32 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
	Sahil Rihan <srihan@fb.com>, Alexei Starovoitov <ast@fb.com>,
	stable@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: allow TCPA log area to be empty
Message-ID: <20180312150231.GA24717@ziepe.ca>
References: <20180310161637.7723-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180310161637.7723-1-jarkko.sakkinen@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594568062770347163?=
X-GMAIL-MSGID: =?utf-8?q?1594744591211010065?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 10, 2018 at 06:16:37PM +0200, Jarkko Sakkinen wrote:
> TCPA log are can be empty when the TPM is disabled. This commit changes the
> behavior of tpm_read_log_acpi() to return successfully in this case.

The commit should explain why we'd want this..

eg Why does it matter to create the extra sysfs files to report an empty
log?

Jason
