Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1045436-1521144189-2-14351209696641596284
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='name', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521144188; b=TSkB1K2jGqERLaoQYJixNNiVlGdKY0nP7CYWimYHrKPv3SA
    vvXqrQCXoxgkloMhtfIevVekZ4EK5UT7SO8g8l3aiRcRYh9p/wxmc/xwqiCsU9Bv
    28YHV2FVDvMgwBbYEv8qXffYcblavG0LLLhBZPBIkYTdOkZPg7Jz1211V3Oqd1IG
    X+L5qO4vzI83ISY8MazxvDqQUw7XgXFiSnnsfHpiIzOZ/nXvOcG0+cu3ImNfmDMM
    Z1BmcKPEBscN9b+VOBgeY5qbxc++teuIiUAnr8TPgawOj88/Hwg1mhdesOXRIOMv
    sIZqpo5LJzndkblXZQLLdoKdlU7p2hdJNixIE/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:subject:in-reply-to
    :references:message-id:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :sender; s=arctest; t=1521144188; bh=ZGVjJSvAqBPo306EO79jedOSDgp
    TXPyGxZNYX1w9xB0=; b=niaES821bq9jjhE4DLdhr/J1WNOXmtGCxBBW7tKCqKv
    Jew/48Nl46dB2bdC951H2pWesZqp+X0naHX5BvUUPAXc2kZtiq6xGqfylqWyB7NU
    i8vGZjzlz4VQWTfzH6vn1bJDUSDk/VXxstHIWV6r+U3xfy6P2GG0sj3HRRFQ2wo8
    mipReF9v1LfzM7BBDUMe0ERlrg8dfytxBB2+G6cmXW9kDMcrRrAN8Wa5Wvw4It1e
    TxWpFgA5cLSCplkGeYbPzkFW+kyttaXMYznNKOklpKATPOyb2hGfyJpF4JeJn/Fc
    PtTKFXOPHMs7X2SQeqm2nnALOpSJkGLFYZ7nG0naTRA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=brown.name;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    smime=temperror;
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=brown.name header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=brown.name;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    smime=temperror;
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=brown.name header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: NeilBrown <neil@brown.name>
To: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 16 Mar 2018 07:02:51 +1100
Subject: Re: [PATCH 00/13] staging: add drivers to support Mediatek mt7621 in
 gnubee-pc1
In-Reply-To: <20180315112454.7p6gch4gq7jljk37@mwanda>
References: <152105892255.22262.1902152685410223215.stgit@noble>
 <20180315104853.bthffdd4hzklzo6d@mwanda>
 <87vadxbnwe.fsf@notabene.neil.brown.name>
 <20180315112454.7p6gch4gq7jljk37@mwanda>
Message-ID: <87po45ayz8.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 lkml <linux-kernel@vger.kernel.org>, John Crispin <john@phrozen.org>
Content-Type: multipart/mixed; boundary="===============1906470501399002963=="
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--===============1906470501399002963==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 15 2018, Dan Carpenter wrote:

> On Thu, Mar 15, 2018 at 10:04:33PM +1100, NeilBrown wrote:
>> On Thu, Mar 15 2018, Dan Carpenter wrote:
>>=20
>> > This all seems fine.  Generally the requirements for staging are that =
it
>> > has a TODO, someone to work on it, and it doesn't break the build.  But
>> > some of the patches don't have commit message and those are required a=
nd
>> > some of the commit messages are just the changes you have made not don=
't
>> > describe the actual code...
>>=20
>> Thanks for having a look.
>> It seems odd to require detailed commit messages, when we don't require
>> the same level of quality in the code.
>> Naturally when the driver is moved out of staging a properly detailed
>> commit message should be added, but is that needed on the way in to
>> staging?  At this stage I don't know much more than is already there.
>> After I've cleaned up the code I probably will.
>>=20
>> For patch 01/13 you asked "what kind of device this is".  The subject
>> line makes it clear that it is a "pcie driver".  What extra detail did
>> you want?  Would it be sufficient to just copy the subject line so that
>> it appears twice in the commit message?
>>=20
>
> Ah...  Sorry.  It's literally a pcie driver.  For some reason I thought
> it was a device that ran over pcie.
>
> We don't require a detailed changelog, but you have to put something...
> Probably just restating the subject and adding that it's for the gnubee1
> is fine.

I'll resend sometime next week with more words.  However could you
please clarify a couple of things for me?

1/ Why do you (sometimes) call the commit message a "change log".  When
  I see the term "change log" in the context of a patch, my first
  thought is that it it means a log of changes that have been made to
  the patch - typically through the review cycle.  But that isn't what
  you mean.  This has confused me a couple of times.

2/ Why don't you consider the first line of the commit message to be
   part of the commit message?  Why is duplication required?
   (You said "some of the patches don't have commit message[s]",
   which isn't true, though some of the messages are only one line).

Maybe the requirements on the commit message (including this
duplication) could be included in the "Staging trees" section of
Documentation/process/2.process.rst.
That file only lists the TODO and "doesn't break the build"
requirements.  It doesn't metion the "someone to work on it" requirement.
That might seem obvious, but it doesn't hurt to be explicit.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlqq0WsACgkQOeye3VZi
gblPTQ//amGm/xZvWuYmDHQZ8zmEjyh/lrsc2QJddlMoDEEUEnW2OpF2B2w9fqua
gciFe4oPbsucoCpw0yklKUpbdrOeZwdi7mrcOP8ENKUB+S9toZLLf59fqU12MXLY
ah71bt0LG1FrYPOnzvXyiVApa8eR4lWi/o8d0g9D2oxFsKJ4hhXnyc+OimntTwhb
TzfsD12+KzdKgkUmGWkMFPqfWdfB+rghoGpvzwzlHpKOw04pTRS1Qe4gfNjrUUgh
4CWcz+kgq1Mkbjakls9BcYphbiSW6OBdIx48VerJeeoEka3PKWr6MNPNOSQpypOU
PcU6ntggPfxn1Qc2jLU32u3Ra1a8eR7aqxez5cPiqXMv/KBqVMAmW8e21ya+q8Du
5Jcbn++OUW4fdq35S2VySL9lGUykxCRohLKdnXPFjHtrs6/8faq8ohKl2XZ632eU
PTPmhAyxtkYVe8bowvr1dbO278fFwKNk6fYaha23riHb5i4wd160QwltD9CCcy2U
3cYlcPszhezulpBDiTTSFsESkywsdMq3fm10/WBXKMpBLZnnqb1Lk58/+yflR6CP
+ZMOqjcyE8wPmLJTeeNlUVmOgD8W2aIdSRffygd3fXtlVYV3la8M8PAl6LwoYN7T
dbgBr4IbD7hPsJHMm/bgZQYm0l6WYRcbrjb/01Ay9+CCrYp5QW8=
=oUIe
-----END PGP SIGNATURE-----
--=-=-=--

--===============1906470501399002963==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============1906470501399002963==--
