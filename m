Return-Path: <osmithde@osmithde-lnx.cisco.com>
X-Google-Smtp-Source: AIpwx4+DJPKZDL+Bu7pLE2ud3wmWV2HgegavGRaGtHq7kRyW0lv3wCQv2yQxfubs03YLFnUXVD4k
ARC-Seal: i=1; a=rsa-sha256; t=1523303193; cv=none;
        d=google.com; s=arc-20160816;
        b=mFphXWX+twowUZfghZUvUfIkaozeVP+DhMxC/4FGEwX//Av2Hgix7qWb1u+NvXE1Aj
         mwKAsqGv3td6wjfTb0Btv+0E6Yj7W2KvZutzsFy6BmZ2/68LVCVaIHl0O7bgbACHpgy+
         JThBX7GHn93kDB1ARMTHaxGjm0jZTcpOLfoTlkG+dpiNI/uaYRQoFueA9iS2wHFsSmA0
         WiGuABZttgXNrdJRFAGfqChP+HE198rLMMgfaHiQMadghUa4lXA0B6+N2+EFuHqCQwW8
         wo5cHGHimbVV1aTHenWqv0+uCng/6PGt4Pf4ROJup6bzBEkul+vsc/C7L9EsfNrmd9hY
         b6ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=mRYCjdIaK4d+CXIu7a36sEFdIIWyDyOeM8LEl9BiCxc=;
        b=LrBgiLNtUAkijgBrhV4kU2jO/d/YYUzdcZh5TCVHgrA0j6DkVHw0NE90I6RVBJNor/
         /fEWmeIJ9bk0th/nG8U1TBDCVHOcNWXEfOkrfI4wQg7EDj48v/Von/i775FS46zzLLTz
         lYXjbjdF3ikdRtFaQfWUCDFAniutgTuHE9ouRm1Agle/qR392rhuUgp+g93jkE4A+Gze
         fRlQ+5+KpO7U/TbZv9WUfNFoQJYtt3piZ0Y2sXZsnho3qQpCq8Y1C1FoYZ94u1L9zY/P
         T94PWiHL/FPlALqfpXLszfDB8olLnD9ug+xR9/gyumIeuaeo8Y/aT2BTbdnk0yhVMnlc
         4EJQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@cisco.com header.s=iport header.b=aThWTpIN;
       spf=pass (google.com: best guess record for domain of osmithde@osmithde-lnx.cisco.com designates 173.37.86.77 as permitted sender) smtp.mailfrom=osmithde@osmithde-lnx.cisco.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=cisco.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@cisco.com header.s=iport header.b=aThWTpIN;
       spf=pass (google.com: best guess record for domain of osmithde@osmithde-lnx.cisco.com designates 173.37.86.77 as permitted sender) smtp.mailfrom=osmithde@osmithde-lnx.cisco.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=cisco.com
X-IronPort-AV: E=Sophos;i="5.48,427,1517875200";
   d="scan'208";a="378983786"
Date: Mon, 9 Apr 2018 12:49:23 -0700
From: Oliver Smith-Denny <osmithde@cisco.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sesidhar Baddela <sebaddel@cisco.com>,
        Gian Carlo Boffa <gcboffa@cisco.com>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] staging: fnic2 add initialization
Message-ID: <20180409194922.GA24842@osmithde-lnx.cisco.com>
References: <20180405211519.GA12584@osmithde-lnx.cisco.com>
 <20180405211644.GB12584@osmithde-lnx.cisco.com>
 <20180406050752.GC27591@kroah.com>
 <20180406220010.GA23478@osmithde-lnx.cisco.com>
 <20180407060901.GA18744@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180407060901.GA18744@kroah.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596942284542554315?=
X-GMAIL-MSGID: =?utf-8?q?1597299169349489462?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Apr 07, 2018 at 08:09:01AM +0200, Greg Kroah-Hartman wrote:
> Why not just take a week and do that?  I can't take any new patches
> until 4.17-rc1 is out anyway.

Thanks for your help in figuring out the best way forward
for this driver. We will work to finish the TODOs on our
end before 4.17-rc1 is out to see if we can have the driver
in a finished state to submit directly to the SCSI
maintainers. If staging still seems a viable option after
4.17-rc1 comes out, then I will resubmit the patch after
talking with the SCSI developers.
 
> And why not copy the staging developer mailing list on this patch
> series?

My bad, I missed that there was a staging developer mailing list. If
we continue down the staging route, I will CC them.
 
> I'll take anything in staging as long as it has the correct license and
> builds, that's not an issue :)  But I do want to get agreement from the
> SCSI maintainers that this is ok to have in this part of the kernel as
> sometimes it can cause merge issues if there are core api changes.

Sounds good. Thanks again for all your help.

Oliver Smith-Denny
