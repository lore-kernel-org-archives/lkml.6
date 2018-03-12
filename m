Return-Path: <jarkko.sakkinen@linux.intel.com>
X-Google-Smtp-Source: AG47ELs7tBXysg8uhy48mjgRS65TccIwIwmVZwcwl+VOt6yKY/PwssJJCdqqv2iIopWlhRu/QzBm
ARC-Seal: i=1; a=rsa-sha256; t=1520852950; cv=none;
        d=google.com; s=arc-20160816;
        b=wk4eg5LbvBOjo7Dacte/jsPz8YiGOd1Zc6O+5RRqAbiKI8Ux7XNjgeRDSIy4wVKL7n
         Svk66xaCZ49BzdIAa/2H/Dwm3LhPnJ8Mnxs2pl7YbRAJSRnySf1uywv1fv2AYoGhUA65
         1ayTUxe+XZXL0t6KAKYyGCytYnPHiAIMHVgyvgHlPFsWlDwRQF04ia7SiPBjctkEdTbo
         f6XeyjTpKyRdevgFVSL2vZ5I6hu6x2ZSsNp3tCUohUf+gmU/ACwRN55z8enV6ihXCgyX
         6C9k4R1z1LPBD5C0QOhpGnVpkplK5qV9Siesl+KGbUrRlx+Uo0qDbxAWVh5kk+pnpbC0
         X8ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:organization:in-reply-to:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=mZKD4XMbCPelhGDqfQEC5MNyrQiVQ/1sIA5fF1p1z2M=;
        b=Pg88424m3VOvRsPZF4fKX3a16hFWuh6jQWqXJJDUjatxMU1AtHjxwkMSsL36PdCLYv
         +3bLvAhmPRfNE3BkxRevz3ez8MToV26DtsV+0ReKF7GV9SJUvqDqTyJ6Ux/Txv/kcxVA
         56PRqduv7dl0VBYo2FLMnTfce+RYugPC9b1LFuZWpDb+TLjJ+JP8L1X0qyfMCagnJ+uf
         jlaelqAdXzl67sF1dmby2SUKmPVYCJ7+3vbX1gujTUAHuqJeb/pHeCt3xELE9MT2gWso
         F+ucjWCedlswW0NMnWPw491qfVpPZ+RZQWQ0OG8oU/yWDFciGD1FObBuW4uqZUrhcRde
         2mDg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jarkko.sakkinen@linux.intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=jarkko.sakkinen@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jarkko.sakkinen@linux.intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=jarkko.sakkinen@linux.intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,460,1515484800";
   d="scan'208";a="27273654"
Date: Mon, 12 Mar 2018 13:09:07 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, Sahil Rihan <srihan@fb.com>,
	Alexei Starovoitov <ast@fb.com>, stable@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: allow TCPA log area to be empty
Message-ID: <20180312110907.GA7448@linux.intel.com>
References: <20180310161637.7723-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180310161637.7723-1-jarkko.sakkinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594568062770347163?=
X-GMAIL-MSGID: =?utf-8?q?1594729903482356186?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 10, 2018 at 06:16:37PM +0200, Jarkko Sakkinen wrote:
> TCPA log are can be empty when the TPM is disabled. This commit changes the
> behavior of tpm_read_log_acpi() to return successfully in this case.
> 
> Cc: stable@vger.kernel.org
> Fixes: 55a82ab3181b ("[PATCH] tpm: add bios measurement log")
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Already applied to my master (bleeding edge) branch in order to
facilitate testing:

git://git.infradead.org/users/jjs/linux-tpmdd.git

/Jarkko
