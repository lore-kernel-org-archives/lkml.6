Return-Path: <vitezslav@samel.cz>
X-Google-Smtp-Source: AIpwx4+DjKLbB7cjz0OKIlxG9jz+lPY0tO7g/Kxq6UKJfS23lZghNVXD4CFWPJrtKlFcWiSWamio
ARC-Seal: i=1; a=rsa-sha256; t=1524221649; cv=none;
        d=google.com; s=arc-20160816;
        b=Oe142mp5SSFJJQpJGsPQcWDn4Vjc6stWzJRY3RBhBB6//6We3y0Cg/+lGwxkSE1FXl
         3buCLamVObeen34s6NFdgXZrZLdrCDPHbEy33jsoLFTSZnQS3NTbnyzfNFwv6UxH8BXR
         paZuixkAgtSiz2w7Orj+aOC7fLUYOEkjFTFemziYqu3krKrq/HKbzm83OPXDS/LutXUe
         8kVOANqvtswsPuqVMjdyW9cMTPMCHIh1vJ+0ESVW13aesTlBeS8nQfcQlqNif1l7b1cw
         Vp4jz+zkz6Z3qpPCxywTk9x7o0nCsFjlFtUnnDHzG55uOrXXVTHSytYZ3sDnxIlWsyyS
         sa2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:mail-followup-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=NCRVa90kwT2ZrikMR8ciGhuHr4WWzLYxA5WUOFxYXz4=;
        b=guX4hkWlBPmyU5Pg828V1GQ9C1Q22eDCRXAsv78LK+nXUJ2L/qx7fqTnBy+PGW2osA
         88e/P6WBdq1uv2ZbUg2luVEactZXYnKo3GOtZj4RhCPEAB9nD1eIkk4nJ3VcRDMzE70u
         WvPMlLZTOwDGzf5/GB03LfoNc0fx8xtfIC4Lp3DtJm07dTWX0C2S+Onkc5JNBTpGLFD5
         Np5Qop0pXn9KmPlrnmNKM6zSy5t11giog76rlwTzAAboR+OmU9IDsAekGtBZPVAA7gcY
         l17TtJCZvVMu3oQiiRbCRDtdWlW8iRVHuj3mpm26i1LPUqZQyiIbSegyhHb+B4crlv0s
         7nTw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 213.155.227.146 is neither permitted nor denied by best guess record for domain of vitezslav@samel.cz) smtp.mailfrom=vitezslav@samel.cz
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 213.155.227.146 is neither permitted nor denied by best guess record for domain of vitezslav@samel.cz) smtp.mailfrom=vitezslav@samel.cz
Date: Fri, 20 Apr 2018 12:54:08 +0200
From: Vitezslav Samel <vitezslav@samel.cz>
To: Borislav Petkov <bp@suse.de>
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, x86-ml <x86@kernel.org>
Subject: Re: [PATCH 1/2] x86/microcode/intel: Save microcode patch
 unconditionally
Message-ID: <20180420105408.GA2257@pc11.op.pod.cz>
Mail-Followup-To: Borislav Petkov <bp@suse.de>,
	"Raj, Ashok" <ashok.raj@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, x86-ml <x86@kernel.org>
References: <20180419104829.GE3896@pd.tnic>
 <20180419120239.GA2377@pc11.op.pod.cz>
 <20180419121840.GF3896@pd.tnic>
 <20180419134627.GA2387@pc11.op.pod.cz>
 <20180419163734.GB3905@pd.tnic>
 <20180420062021.GA2253@pc11.op.pod.cz>
 <20180420095220.GA13977@pd.tnic>
 <20180420100131.GA14217@pc11.op.pod.cz>
 <20180420103242.GB13977@pd.tnic>
 <20180420103428.GD13977@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180420103428.GD13977@pd.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598261005085608238?=
X-GMAIL-MSGID: =?utf-8?q?1598262240270756884?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 20, 2018 at 12:34:28PM +0200, Borislav Petkov wrote:
> save_mc_for_early() was a no-op on !CONFIG_HOTPLUG_CPU but the
> generic_load_microcode() path saves the microcode patches it has found
> into our cache of patches which is used for late loading too. Regardless
> of whether we do CPU hotplug or not.
> 
> So make the saving unconditional so that late loading can find the
> proper patch.
> 
> Reported-by: Vitezslav Samel <vitezslav@samel.cz>

  Tested-by: Vitezslav Samel <vitezslav@samel.cz>

> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: <stable@vger.kernel.org> # if it has backported d8c3b52c00a05036e0a6b315b4b17921a7b67997
> Link: http://lkml.kernel.org/r/20180418081140.GA2439@pc11.op.pod.cz
> ---
>  arch/x86/kernel/cpu/microcode/intel.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
> index 32b8e5724f96..1c2cfa0644aa 100644
> --- a/arch/x86/kernel/cpu/microcode/intel.c
> +++ b/arch/x86/kernel/cpu/microcode/intel.c
> @@ -485,7 +485,6 @@ static void show_saved_mc(void)
>   */
>  static void save_mc_for_early(u8 *mc, unsigned int size)
>  {
> -#ifdef CONFIG_HOTPLUG_CPU
>  	/* Synchronization during CPU hotplug. */
>  	static DEFINE_MUTEX(x86_cpu_microcode_mutex);
>  
> @@ -495,7 +494,6 @@ static void save_mc_for_early(u8 *mc, unsigned int size)
>  	show_saved_mc();
>  
>  	mutex_unlock(&x86_cpu_microcode_mutex);
> -#endif
>  }
>  
>  static bool load_builtin_intel_microcode(struct cpio_data *cp)
> -- 
> 2.13.0
> 
> SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
> -- 
