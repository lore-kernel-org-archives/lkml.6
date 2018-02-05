Return-Path: <ruben@mrbrklyn.com>
X-Cyrus-Session-Id: sloti22d1t05-3181489-1517856380-2-10467609011453676431
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, SPF_HELO_PASS -0.001, SPF_PASS -0.001,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='96.57.23.82', Host='www2.mrbrklyn.com', Country='US', FromHeader='com',
  MailFrom='com'
X-Spam-charsets: cc='iso-8859-1', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: ruben@mrbrklyn.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517856379; b=BYIxRACV3WqD++MeZ1MHRr4OAa+b6dybWv/Z5RFOARBbCxm
    JzWr3bFKsj5ehnukTQE7w2XWftlYshx4aJ6iuxQkovDRecBS0gCydrwHbzDxZbUZ
    jBQJOp8NhQ+/gc5y1ca4nDUu/Hrpi5C7YTDSpAoqOK5du6E1lNYB6+U73JTYJiER
    cJCdXuE+hU0lpVS225ji9gaeCgARSSKzLL3TDXWQJETx3Gk2Oc67gyUTah+N9DnT
    p0gXCkBPQzn2yT1/CAs4loBC/vshOGUsFpXEtI2t0xV5p6xPOFPicmucRCPKwA9h
    6O8p7krhmgRT4ztcVMpkeO36Rwk5fBxJdU1Faxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=arctest; t=
    1517856379; bh=CPQuFRwwZgvigrOl/WnHUUifrDJxCRKqNG8dUWn/XjQ=; b=g
    zhStWjQ6FkTFqnsnLPzVbC2KBzu1k19cNVde22OE2F7Oq0T6IVisg7Ul6eWWtrLo
    DBdodAlV45anbSB+Ctqyz7dMzmr2yTPTqYQ79x8kalHkE4aXn+RmR7UDE/DFvQzF
    1WFU7gHfFz0b0IIO9d3XTBhu19ASkd61WznIcqV2kDjOYq6kmZWH1N8+FypsOX/k
    9QiRMqjpecV6KjIZatbTqp0rXKNDfGgaThjT5unyKQlM6CxqdDy22lAnKImz1Yxe
    C8s6LT/wHKJW7feaHJML9o1RIbrs1jwa4GDCMlUe7K/FehVYJkt0GqhLVCotp8vY
    CCRJ5drmgOOBfDG56fOxA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=mrbrklyn.com;
    iprev=pass policy.iprev=96.57.23.82 (www2.mrbrklyn.com);
    spf=pass smtp.mailfrom=ruben@mrbrklyn.com smtp.helo=mrbrklyn.com;
    x-aligned-from=pass;
    x-ptr=fail x-ptr-helo=mrbrklyn.com x-ptr-lookup=www2.mrbrklyn.com;
    x-return-mx=pass smtp.domain=mrbrklyn.com smtp.result=pass smtp_is_org_domain=yes header.domain=mrbrklyn.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=mrbrklyn.com;
    iprev=pass policy.iprev=96.57.23.82 (www2.mrbrklyn.com);
    spf=pass smtp.mailfrom=ruben@mrbrklyn.com smtp.helo=mrbrklyn.com;
    x-aligned-from=pass;
    x-ptr=fail x-ptr-helo=mrbrklyn.com x-ptr-lookup=www2.mrbrklyn.com;
    x-return-mx=pass smtp.domain=mrbrklyn.com smtp.result=pass smtp_is_org_domain=yes header.domain=mrbrklyn.com header.result=pass header_is_org_domain=yes
Date: Mon, 5 Feb 2018 13:46:17 -0500
From: Ruben Safir <ruben@mrbrklyn.com>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Greg KH <greg@kroah.com>, sil2review@lists.osadl.org,
	kernelnewbies@kernelnewbies.org, David Airlie <airlied@linux.ie>,
	intel-gfx@lists.freedesktop.org,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	llvmlinux@lists.linuxfoundation.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Ozan Alpay <ozyalpy@gmail.com>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: clang warning: implicit conversion in intel_ddi.c:1481
Message-ID: <20180205184616.GA29539@www2.mrbrklyn.com>
References: <alpine.DEB.2.20.1802011823340.4316@alpaca>
 <20180201180240.GA28042@kroah.com>
 <alpine.DEB.2.20.1802012045570.29994@hsp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1802012045570.29994@hsp>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> 
> We are interested 


who is we?
