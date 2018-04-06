Return-Path: <osmithde@osmithde-lnx.cisco.com>
X-Google-Smtp-Source: AIpwx482edVUapNyanXIn95XZs4KV2HXyILIQpMHSs8j/cwmwXEhC6QgsacD+/bovo4z0QE+0tr1
ARC-Seal: i=1; a=rsa-sha256; t=1523051845; cv=none;
        d=google.com; s=arc-20160816;
        b=PiAtPFMbLLEC05E8/qfGWrBXvz6gwLz//RIx3rXxtwwIWm3als6ALZL7hd8qhC0Nd0
         rMXfJal62W3DkgNaFtgdqXeut8ePPResT6DlCwugE7PMh50QWeOhXPCuMFpd01pm/aHV
         ei9mxCxqmBvCANmgN0pvVGGRIRn0AbaYJKL5JjFFA4AGOob8HmWG5SAG90YPcTwBUnel
         RFPSjJD2sLUurP/r+PyMP+GuC3fuXyBfxxRUBdLuzrdHcF6rilLckzVuVQvwCyilmoSX
         9ZS6XqsZI+t4cAZ7LJrARk2CQv2OSjEdS58CG5pIGwblAEevUJyE+wK1SpkoQg5WbzrE
         MN6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=dNlsJiw5X3KRemBvk5RlkZPhxkonosNVs5g0lnzL3Zc=;
        b=OASZEqsxo+GILuTiSSOF1kgqX3FBVlvqPHV63Ae+PYNnOA8Vd8sDexiEhEnEnau1AG
         Auu7oQjNSwUG8/70rjisST9KiAyBaLlIAVT45LwXmlC+pyDKekeOmtMCQF/FBhrgc+nU
         OzzWlqyu/QQJGsXaBuDJauRfgqBlH6XMeR8f0hLLQhwTEVAS/YevtTQnBN59I41lVwqA
         v/vw+09RgAHwD97pMtS6hWehIOFCpNqoBDcgBhIg+9wyLQDou4rm8D9YY5W34rSC3chG
         mn2AS1C8lzjB5DylTMYqph82tdMRrC6l6gdoTmJ5fcXY3yWyPeDhgsqtb/ykODJAbM7B
         hkGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@cisco.com header.s=iport header.b=VRkh0hYu;
       spf=pass (google.com: best guess record for domain of osmithde@osmithde-lnx.cisco.com designates 173.37.86.77 as permitted sender) smtp.mailfrom=osmithde@osmithde-lnx.cisco.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=cisco.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@cisco.com header.s=iport header.b=VRkh0hYu;
       spf=pass (google.com: best guess record for domain of osmithde@osmithde-lnx.cisco.com designates 173.37.86.77 as permitted sender) smtp.mailfrom=osmithde@osmithde-lnx.cisco.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=cisco.com
X-IronPort-AV: E=Sophos;i="5.48,417,1517875200";
   d="scan'208";a="377734788"
Date: Fri, 6 Apr 2018 15:00:11 -0700
From: Oliver Smith-Denny <osmithde@cisco.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sesidhar Baddela <sebaddel@cisco.com>,
        Gian Carlo Boffa <gcboffa@cisco.com>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oliver Smith-Denny <osmithde@cisco.com>
Subject: Re: [PATCH 01/10] staging: fnic2 add initialization
Message-ID: <20180406220010.GA23478@osmithde-lnx.cisco.com>
References: <20180405211519.GA12584@osmithde-lnx.cisco.com>
 <20180405211644.GB12584@osmithde-lnx.cisco.com>
 <20180406050752.GC27591@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406050752.GC27591@kroah.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596942284542554315?=
X-GMAIL-MSGID: =?utf-8?q?1597035612265063364?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 06, 2018 at 07:07:52AM +0200, Greg Kroah-Hartman wrote:
> Why is this a drivers/staging/ driver at all?  What is keeping you from
> getting this merged into the "proper" place in the kernel?
> 
> If you have a staging driver, you have to have a TODO file in the
> directory listing what is keeping this in the staging section.

Sorry Greg, we do have a TODO file in the directory, but it was
part of patch 10/10. I can move that to be part of patch 01/10.

We think that this driver is a drivers/staging driver because
there are some changes we want to make before submitting
the driver to the "proper" place. Specifically, we want to
change how we allocate memory (move from a static allocation
to a mempool scenario), which will require some other code
changes. Also, we want to investigate if we need to change
our locking schema. We think that making this driver
part of the drivers/staging community will allow interested
people to try the driver in its current state and offer up
ideas as to its continued development.

If you think that this driver doesn't belong in the
drivers/staging community, we are happy to explore getting
the driver fully ready on our side and getting it into the
"proper" place.

> Please read the documentation on how to properly use SPDX tags on kernel
> files.  This needs to be the first line of the file.

Thanks Greg, I fixed the SPDX tags and removed all the boilerplate,
including the LICENSE file. Also, I have updated the MAINTAINERS
file, which accidentally slipped by my first patch set. If you
think that drivers/staging is a good temporary home for this
driver, then I will send another patchset with the changes,
as well as the changes from your other replies to patch 02/10
and patch 03/10.

Thanks for your help,

Oliver Smith-Denny
