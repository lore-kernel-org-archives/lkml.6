Return-Path: <zohar@linux.vnet.ibm.com>
X-Google-Smtp-Source: AIpwx4+MsPsIxwwYkoiN963pkqaS6w/NhJVLNOtRfRGhTd2/7QmO4sANIW+ZuZ1Ze5gsNLbx8HuH
ARC-Seal: i=1; a=rsa-sha256; t=1522936884; cv=none;
        d=google.com; s=arc-20160816;
        b=MIVSQRSA/VFIljn2xFQw/hxdFf5wn5ErXIMW1faUWwpDRMLTNho0NPtqyokiJic6tf
         6yhsFZE0gMkO45eDCcYSRlzGRoUmTQrPr2JapFLtAv3Ppr/kjGXmU9tqBGGM/qZCwiAF
         a75HC9oPhzGclrSwvC9oGFSWXkV34Z25xg90G4WoFZ45KEKoUfgfD2yQ8xNQExNLtx6w
         7wxgAQB103Xywcs+GHsEqrzCZeIFqwfyNH7uFj7QdyYIwCDqs8e757wBewjJw1saSHdh
         11W+ZMo5LQjMtjGudNyowwp8B2i3YimM8c20wwu9KmJ/1CneuqFYruH6lupXbuJ5OC0w
         mEBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:mime-version:references
         :in-reply-to:date:cc:to:from:subject:arc-authentication-results;
        bh=zokNviR9uuH4tkvyokOKtDZIxTKuqIScyx/iFeFkXpU=;
        b=ivt+/lfeMYTDPDxjjJyxFpqWVVyrqyZ1TgcEPpj/4SOqLVGFG14cBfLOu9VoP9PFtz
         BCOC01OAiu7+zcw+ntpXYSptuI52hO5k4NosWOT3ZWs2IP21cxRhaEAvBZ/VtDzwl/9c
         6aT52SVBfaVyVA+WjRDDiuKrUOlOxRTt68b7uQtmypbv46hp2A9OMh36AS38tuCr+MSF
         Mv7qmetFa0XY+EOsKbD6Odg+7Dq8cB8HQEZApR5cKsHfgGKpMoVj5q8c5xWVUcbv+prh
         eJ0VEVKactabiVRnIaE8LWGBDyu5/g+G+/jLFp1IXSPpP2Peb+/rsc/3DO8QUfMgKCeC
         rPiw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of zohar@linux.vnet.ibm.com) smtp.mailfrom=zohar@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of zohar@linux.vnet.ibm.com) smtp.mailfrom=zohar@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: An actual suggestion (Re: [GIT PULL] Kernel lockdown for secure
 boot)
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: joeyli <jlee@suse.com>, David Howells <dhowells@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>,
        Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Matthew
 Garrett <mjg59@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morris
 <jmorris@namei.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>,
        Justin Forbes
 <jforbes@redhat.com>,
        linux-man <linux-man@vger.kernel.org>,
        LSM List
 <linux-security-module@vger.kernel.org>,
        Linux API
 <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-efi
 <linux-efi@vger.kernel.org>
Date: Thu, 05 Apr 2018 10:01:09 -0400
In-Reply-To: <20180405021650.GC7362@linux-l9pv.suse>
References: <CALCETrUVQLDC6_VEvuAbdCOuGrmcxohqTB6P8eyNojm9AryNkg@mail.gmail.com>
	 <1119.1522858644@warthog.procyon.org.uk>
	 <20180405021650.GC7362@linux-l9pv.suse>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18040514-0012-0000-0000-000005C76E53
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040514-0013-0000-0000-0000194385CF
Message-Id: <1522936869.16421.63.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-05_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804050148
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596827498960319998?=
X-GMAIL-MSGID: =?utf-8?q?1596915065999098827?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 2018-04-05 at 10:16 +0800, joeyli wrote:
> Hi David, 
> 
> On Wed, Apr 04, 2018 at 05:17:24PM +0100, David Howells wrote:
> > Andy Lutomirski <luto@kernel.org> wrote:
> > 
> > > Since this thread has devolved horribly, I'm going to propose a solution.
> > > 
> > > 1. Split the "lockdown" state into three levels:  (please don't
> > > bikeshed about the names right now.)
> > > 
> > > LOCKDOWN_NONE: normal behavior
> > > 
> > > LOCKDOWN_PROTECT_INTEGREITY: kernel tries to keep root from writing to
> > > kernel memory
> > > 
> > > LOCKDOWN_PROTECT_INTEGRITY_AND_SECRECY: kernel tries to keep root from
> > > reading or writing kernel memory.
> > 
> > In theory, it's good idea, but in practice it's not as easy to implement as I
> > think you think.
> > 
> > Let me list here the things that currently get restricted by lockdown:
> > 
> [...snip]
> >  (5) Kexec.
> >
> 
> About IMA with kernel module signing and kexec(not on x86_64 yet)...

Only carrying the measurement list across kexec is architecture
specific, but everything else should work.  

> Because IMA can be used to verify the integrity of kernel module or even
> the image for kexec. I think that the
> IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY must be enabled at runtime
> when kernel is locked-down.

I think we need to understand the problem a bit better.  Is the
problem that you're using the secondary keyring and loading the UEFI
keys onto the secondary keyring?

> Because the root can enroll master key to keyring then IMA trusts the ima key
> derived from master key. It causes that the arbitrary signed module can be loaded
> when the root compromised.

With only the builtin keyring, only keys signed by a builtin key can
be added to the IMA keyring.

Mimi
