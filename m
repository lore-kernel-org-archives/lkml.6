Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AB8JxZq2Qtpe/xM4QsEH3IUlSNqGAOteOjK9ECD8ux4EHK99y2R0Q5tAB20IKu0gWnroUnwWiyel
ARC-Seal: i=1; a=rsa-sha256; t=1524468862; cv=none;
        d=google.com; s=arc-20160816;
        b=MIOiDGGR9unqQ0Zv75VGcfosDT733GhnTN3E22kwD+2iVhK8r5R/tJT57LpcwIIbQI
         UeBU0LSRxk0x+kHih6LaFmHxmVFwySmqXkn0Q3KtuCs0T52dKX6iIi+gsdap0u6mlmQE
         KqgIhkEJv/+PuUm6JujTkoeAmN5BPlFjVOqCcj6TykAD1ZeHoY1/F959pTFycjqXFQVH
         peAmohqgDPAASpop9kFzOYAJGNvQo9zdAXlfEurCzIrhPvNUe+Q9UXnDKPFt34qUeSRv
         pvRU8JmiTmpEkuEmK2FPs60kGmiHPPXzB8KVllCRVUlButarXx1w1CsUL5/RCnATqh+F
         yA3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=IZEWW79ZSHK4MhHAscoizrkFm96KUcY8tJnXhvwIWT0=;
        b=ZfBS83zdsCvQnb7HUyEIDXr0lajFYaAYdqgkz6sH2mDGFtZxE+dlyIkc3QRpZsRy1S
         qKCl1vC+ToXX8d1FrJNm6rKyNtb9ydgW/iAwuZFrQVsix+g/uXPj+wK2eQ+KgRwonr9R
         Zxau0eEjdvPZo4hP6SEkNm57ZB9vJgjhzfP6d+CSnHSknX7QTUgJ0qMluRUDCK4oBPFi
         7VXUdtjgFFPsu3XDyUtM37e/A3I+biHVL0u0jlfE8yBv6jrMXIH9f5H00UEA5c07dDtA
         DlaNN9uvuLZrrXkgrOIWkiazjvQoinrEq7paM+VWVqW7Ee0VnS+0TjomnR8s8H66gHD6
         gRGA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Date: Mon, 23 Apr 2018 09:34:19 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: LKML <linux-kernel@vger.kernel.org>,
    Philippe Ombredanne <pombredanne@nexb.com>,
    Kate Stewart <kstewart@linuxfoundation.org>,
    Jonathan Corbet <corbet@lwn.net>
Subject: Re: [patch 0/9] LICENSES: Add missing License Text and fixup bogus
 identifiers
In-Reply-To: <20180423065700.GG4208@kroah.com>
Message-ID: <alpine.DEB.2.21.1804230931050.6136@nanos.tec.linutronix.de>
References: <20180422220208.772527041@linutronix.de> <20180423065700.GG4208@kroah.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598486095151406011?=
X-GMAIL-MSGID: =?utf-8?q?1598521461715460408?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 23 Apr 2018, Greg Kroah-Hartman wrote:
> On Mon, Apr 23, 2018 at 12:02:08AM +0200, Thomas Gleixner wrote:
> > There are a few bogus SPDX identifiers in various files and SPDX
> > Identifiers used in tree or about to be used which have no corresponding
> > License Text file in the LICENSES directory or use the new variant of the
> > GPL-2.0[+] license identifiers which are not mentioned in the GPL-2.0
> > Valid-License-Identifiers: tags.
> > 
> > The following series cleans that up:
> > 
> >  - Use the proper identifiers
> > 
> >  - Add GPL-2.0-only and GPL-2.0-or-later identifiers to the GPL2.0 license
> > 
> >  - Add X11, Apache-2.0, CC-BY-SA-4.0, CCDL-1.0, Linux-OpenIB license texts
> >    to the LICENSES directory along with the required documentation texts
> 
> I'm thinking we need a script to keep these in check, right?  Does
> checkpatch.pl handle knowing what the "currently good" list of license
> tags are, or should we just use a separate script to parse the LICENSES/
> directory to get that list?

checkpatch.pl does not know about it. I have a python script which does the
parsing of the LICENSES directory and checks against every file in the
tree. I need to make that work with patches. I'm not sure whether
checkpatch.pl should grow all the parser knowledge, I guess it can just
invoke the script and be done with it.

Thanks,

	tglx
