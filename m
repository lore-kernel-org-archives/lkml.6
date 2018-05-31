Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2089784-1527805649-5-17239111616988917013
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Attached: signature.asc
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527805649; b=B62294PcC5nECAhAKKPYasTV764Ujx6uHLv9BoKehZuhFp+/+f
    AnKF0Gz8wQueVNLM7BXosVKw7XVL7Q6loU6VEDoDgxgc2oIG9MH8/JOCluDU+xI1
    n0bskC1lawHGOjJkpkJPHEPv5BuEK4EXSz5hBT0zvtqzNEmzUFSQAA53sgPl8RVP
    PLuKFxt14+/nOj3W7lzkjoYTgq3wTV01mTU15uFVN+9s26Y6enuo8l/0FAynpJEC
    wSFW/3eWCmJCJIFFLDIQtQgfVg3FUaG9F/eO9J+CPWpbTzgES12LzTK1liuXKsvi
    lNhgDljh6YlKIkMvX/eomqEwHGmUJRkdA4Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:cc:subject:in-reply-to
    :references:cc:message-id:mime-version:content-type:sender
    :list-id; s=fm2; t=1527805649; bh=fSZRjm9BGm/GDnZHVxYpQ2sOIM2vKQ
    iJh5DFJmgX1Jw=; b=ErY/EpGKmC6g74wD6KyQgZr/rUmkQ9y+zXYhqVqzHTx5DR
    XEYjEUPusKj4q1UyTPdIG2RRPswzQIX6dHnUdQf9K2EWv+8GaFK/aaBczPd767ZZ
    3esIswf4fvpaFiLkvIl1k4V4UMWWptoe98xUplxuqphIUz2D/V/bbNKAairATaIP
    AZVKT1Lu9EEaFOdyJxCUq4gcG6GuZT6I9Uqwz3ZBN9w0v0iDQBF9yjVv25/giqsm
    omFFsZwuRxt0n9PmTZ5MpvXYu8J6u+NE37FxX0MXBF9C8nyIYIMSYLDFql7IfCyp
    tdBo0SA5NtiSofNFj0zbrUfZQhRrEGlu4f1vxpvg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF0Eeiuy/oTfNSOwfVsZ1xJjZjE1L7pSezHotl7/wcJPY4QL0e42vesplSKyjcnAvV3K6igE0RA5Up14c9TrJmH+Vdrau5pRBLRaKCVMrf8ht3ZAmP91
    lSom1uduaMQEBZdJCAPxyMaOwNMJM7AWCoyHUwz4RaPK4XtSeQSwlzhkIwYV7ty8i78Lb4pVvOBXwZ/jW5RW9NaNcOiRfzgzjMPQAoHx0CaGgGo3hm3h4dCH
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=1oJP67jkp3AA:10 a=VUJBJC2UJ8kA:10
    a=ZZnuYtJkoWoA:10 a=07d9gI8wAAAA:8 a=iox4zFpeAAAA:8 a=sDD4rhkp4mmcaGYFJTsA:9
    a=dWqoElHQ5zJWs5A2:21 a=UrVtiDHcmD3muQd3:21 a=Bqx4bGZaHP8i8yDK9v4A:9
    a=ONNS8QRKHyMA:10 a=e2CUPOnPG4QKp8I52DXD:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751170AbeEaW1X (ORCPT <rfc822;linux@kroah.com>);
        Thu, 31 May 2018 18:27:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:40243 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750902AbeEaW1M (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 May 2018 18:27:12 -0400
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "Cc"
From: NeilBrown <neilb@suse.com>
To: Andrew Morton <akpm@linux-foundation.org>
Date: Fri, 01 Jun 2018 08:26:57 +1000
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH resend*2] VFS: simplify seq_file iteration code and interface
In-Reply-To: <87fu3dihtf.fsf@notabene.neil.brown.name>
References: <87vacsrt0r.fsf@notabene.neil.brown.name> <87fu3dihtf.fsf@notabene.neil.brown.name>
CC: Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <874lintqa6.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


The documentation for seq_file suggests that it is necessary to be
able to move the iterator to a given offset, however that is not the
case.  If the iterator is stored in the private data and is stable
from one read() syscall to the next, it is only necessary to support
first/next interactions.  Implementing this in a client is a little
clumsy.
=2D if ->start() is given a pos of zero, it should go to start of
  sequence.
=2D if ->start() is given the same pos that was given to the most recent
  next() or start(), it should restore the iterator to state just
  before that last call
=2D if ->start is given another number, it should set the iterator one
  beyond the start just before the last ->start or ->next call.


Also, the documentation says that the implementation can interpret the
pos however it likes (other than zero meaning start), but seq_file
increments the pos sometimes which does impose on the implementation.

This patch simplifies the interface for first/next iteration and
simplifies the code, while maintaining complete backward
compatability.  Now:

=2D if ->start() is given a pos of zero, it should return an iterator
  placed at the start of the sequence
=2D if ->start() is given a non-zero pos, it should return the iterator
  in the same state it was after the last ->start or ->next.

This is particularly useful for interators which walk the multiple
chains in a hash table, e.g. using rhashtable_walk*. See
fs/gfs2/glock.c and drivers/staging/lustre/lustre/llite/vvp_dev.c

A large part of achieving this is to *always* call ->next after ->show
has successfully stored all of an entry in the buffer.  Never just
increment the index instead.
Also:
 - always pass &m->index to ->start() and ->next(), never a temp
   variable
 - don't clear ->from when ->count is zero, as ->from is dead when
    ->count is zero.

Some ->next functions do not increment *pos when they return NULL.
To maintain compatability with this, we still need to increment
m->index in one place, if ->next didn't increment it.
Note that such ->next functions are buggy and should be fixed.
A simple demonstration is
   dd if=3D/proc/swaps bs=3D1000 skip=3D1
Choose any block size larger than the size of /proc/swaps.
This will always show the whole last line of /proc/swaps.

This patch doesn't work around buggy next() functions for this case.

Acked-by: Jonathan Corbet <corbet@lwn.net> (For the docs part)
Signed-off-by: NeilBrown <neilb@suse.com>
=2D--

Hi Andrew,
 maybe I've been sending this to the wrong address.  You seem to have
 processed a few seq_file patches lately - maybe you could review/take
 this one too?
Thanks,
NeilBrown


 Documentation/filesystems/seq_file.txt | 63 ++++++++++++++++++++++--------=
----
 fs/seq_file.c                          | 53 +++++++++++-----------------
 2 files changed, 62 insertions(+), 54 deletions(-)

diff --git a/Documentation/filesystems/seq_file.txt b/Documentation/filesys=
tems/seq_file.txt
index 9de4303201e1..d412b236a9d6 100644
=2D-- a/Documentation/filesystems/seq_file.txt
+++ b/Documentation/filesystems/seq_file.txt
@@ -66,23 +66,39 @@ kernel 3.10. Current versions require the following upd=
ate
=20
 The iterator interface
=20
=2DModules implementing a virtual file with seq_file must implement a simple
=2Diterator object that allows stepping through the data of interest.
=2DIterators must be able to move to a specific position - like the file th=
ey
=2Dimplement - but the interpretation of that position is up to the iterator
=2Ditself. A seq_file implementation that is formatting firewall rules, for
=2Dexample, could interpret position N as the Nth rule in the chain.
=2DPositioning can thus be done in whatever way makes the most sense for the
=2Dgenerator of the data, which need not be aware of how a position transla=
tes
=2Dto an offset in the virtual file. The one obvious exception is that a
=2Dposition of zero should indicate the beginning of the file.
+Modules implementing a virtual file with seq_file must implement an
+iterator object that allows stepping through the data of interest
+during a "session" (roughly one read() system call).  If the iterator
+is able to move to a specific position - like the file they implement,
+though with freedom to map the position number to a sequence location
+in whatever way is convenient - the iterator need only exist
+transiently during a session.  If the iterator cannot easily find a
+numerical position but works well with a first/next interface, the
+iterator can be stored in the private data area and continue from one
+session to the next.
+
+A seq_file implementation that is formatting firewall rules from a
+table, for example, could provide a simple iterator that interprets
+position N as the Nth rule in the chain.  A seq_file implementation
+that presents the content of a, potentially volatile, linked list
+might record a pointer into that list, providing that can be done
+without risk of the current location being removed.
+
+Positioning can thus be done in whatever way makes the most sense for
+the generator of the data, which need not be aware of how a position
+translates to an offset in the virtual file. The one obvious exception
+is that a position of zero should indicate the beginning of the file.
=20
 The /proc/sequence iterator just uses the count of the next number it
 will output as its position.
=20
=2DFour functions must be implemented to make the iterator work. The first,
=2Dcalled start() takes a position as an argument and returns an iterator
=2Dwhich will start reading at that position. For our simple sequence examp=
le,
+Four functions must be implemented to make the iterator work. The
+first, called start(), starts a session and takes a position as an
+argument, returning an iterator which will start reading at that
+position.  The pos passed to start() will always be either zero, or
+the most recent pos used in the previous session.
+
+For our simple sequence example,
 the start() function looks like:
=20
 	static void *ct_seq_start(struct seq_file *s, loff_t *pos)
@@ -101,11 +117,12 @@ implementations; in most cases the start() function s=
hould check for a
 "past end of file" condition and return NULL if need be.
=20
 For more complicated applications, the private field of the seq_file
=2Dstructure can be used. There is also a special value which can be return=
ed
=2Dby the start() function called SEQ_START_TOKEN; it can be used if you wi=
sh
=2Dto instruct your show() function (described below) to print a header at =
the
=2Dtop of the output. SEQ_START_TOKEN should only be used if the offset is
=2Dzero, however.
+structure can be used to hold state from session to session.  There is
+also a special value which can be returned by the start() function
+called SEQ_START_TOKEN; it can be used if you wish to instruct your
+show() function (described below) to print a header at the top of the
+output. SEQ_START_TOKEN should only be used if the offset is zero,
+however.
=20
 The next function to implement is called, amazingly, next(); its job is to
 move the iterator forward to the next position in the sequence.  The
@@ -121,9 +138,13 @@ complete. Here's the example version:
 	        return spos;
 	}
=20
=2DThe stop() function is called when iteration is complete; its job, of
=2Dcourse, is to clean up. If dynamic memory is allocated for the iterator,
=2Dstop() is the place to free it.
+The stop() function closes a session; its job, of course, is to clean
+up. If dynamic memory is allocated for the iterator, stop() is the
+place to free it; if a lock was taken by start(), stop() must release
+that lock.  The value that *pos was set to by the last next() call
+before stop() is remembered, and used for the first start() call of
+the next session unless lseek() has been called on the file; in that
+case next start() will be asked to start at position zero.
=20
 	static void ct_seq_stop(struct seq_file *s, void *v)
 	{
diff --git a/fs/seq_file.c b/fs/seq_file.c
index 4cc090b50cc5..fd82585ab50f 100644
=2D-- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -90,23 +90,22 @@ EXPORT_SYMBOL(seq_open);
=20
 static int traverse(struct seq_file *m, loff_t offset)
 {
=2D	loff_t pos =3D 0, index;
+	loff_t pos =3D 0;
 	int error =3D 0;
 	void *p;
=20
 	m->version =3D 0;
=2D	index =3D 0;
+	m->index =3D 0;
 	m->count =3D m->from =3D 0;
=2D	if (!offset) {
=2D		m->index =3D index;
+	if (!offset)
 		return 0;
=2D	}
+
 	if (!m->buf) {
 		m->buf =3D seq_buf_alloc(m->size =3D PAGE_SIZE);
 		if (!m->buf)
 			return -ENOMEM;
 	}
=2D	p =3D m->op->start(m, &index);
+	p =3D m->op->start(m, &m->index);
 	while (p) {
 		error =3D PTR_ERR(p);
 		if (IS_ERR(p))
@@ -123,20 +122,15 @@ static int traverse(struct seq_file *m, loff_t offset)
 		if (pos + m->count > offset) {
 			m->from =3D offset - pos;
 			m->count -=3D m->from;
=2D			m->index =3D index;
 			break;
 		}
 		pos +=3D m->count;
 		m->count =3D 0;
=2D		if (pos =3D=3D offset) {
=2D			index++;
=2D			m->index =3D index;
+		p =3D m->op->next(m, p, &m->index);
+		if (pos =3D=3D offset)
 			break;
=2D		}
=2D		p =3D m->op->next(m, p, &index);
 	}
 	m->op->stop(m, p);
=2D	m->index =3D index;
 	return error;
=20
 Eoverflow:
@@ -160,7 +154,6 @@ ssize_t seq_read(struct file *file, char __user *buf, s=
ize_t size, loff_t *ppos)
 {
 	struct seq_file *m =3D file->private_data;
 	size_t copied =3D 0;
=2D	loff_t pos;
 	size_t n;
 	void *p;
 	int err =3D 0;
@@ -223,16 +216,11 @@ ssize_t seq_read(struct file *file, char __user *buf,=
 size_t size, loff_t *ppos)
 		size -=3D n;
 		buf +=3D n;
 		copied +=3D n;
=2D		if (!m->count) {
=2D			m->from =3D 0;
=2D			m->index++;
=2D		}
 		if (!size)
 			goto Done;
 	}
 	/* we need at least one record in buffer */
=2D	pos =3D m->index;
=2D	p =3D m->op->start(m, &pos);
+	p =3D m->op->start(m, &m->index);
 	while (1) {
 		err =3D PTR_ERR(p);
 		if (!p || IS_ERR(p))
@@ -243,8 +231,7 @@ ssize_t seq_read(struct file *file, char __user *buf, s=
ize_t size, loff_t *ppos)
 		if (unlikely(err))
 			m->count =3D 0;
 		if (unlikely(!m->count)) {
=2D			p =3D m->op->next(m, p, &pos);
=2D			m->index =3D pos;
+			p =3D m->op->next(m, p, &m->index);
 			continue;
 		}
 		if (m->count < m->size)
@@ -256,29 +243,33 @@ ssize_t seq_read(struct file *file, char __user *buf,=
 size_t size, loff_t *ppos)
 		if (!m->buf)
 			goto Enomem;
 		m->version =3D 0;
=2D		pos =3D m->index;
=2D		p =3D m->op->start(m, &pos);
+		p =3D m->op->start(m, &m->index);
 	}
 	m->op->stop(m, p);
 	m->count =3D 0;
 	goto Done;
 Fill:
 	/* they want more? let's try to get some more */
=2D	while (m->count < size) {
+	while (1) {
 		size_t offs =3D m->count;
=2D		loff_t next =3D pos;
=2D		p =3D m->op->next(m, p, &next);
+		loff_t pos =3D m->index;
+
+		p =3D m->op->next(m, p, &m->index);
+		if (pos =3D=3D m->index)
+			/* Buggy ->next function */
+			m->index++;
 		if (!p || IS_ERR(p)) {
 			err =3D PTR_ERR(p);
 			break;
 		}
+		if (m->count >=3D size)
+			break;
 		err =3D m->op->show(m, p);
 		if (seq_has_overflowed(m) || err) {
 			m->count =3D offs;
 			if (likely(err <=3D 0))
 				break;
 		}
=2D		pos =3D next;
 	}
 	m->op->stop(m, p);
 	n =3D min(m->count, size);
@@ -287,11 +278,7 @@ ssize_t seq_read(struct file *file, char __user *buf, =
size_t size, loff_t *ppos)
 		goto Efault;
 	copied +=3D n;
 	m->count -=3D n;
=2D	if (m->count)
=2D		m->from =3D n;
=2D	else
=2D		pos++;
=2D	m->index =3D pos;
+	m->from =3D n;
 Done:
 	if (!copied)
 		copied =3D err;
=2D-=20
2.14.0.rc0.dirty


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlsQdrQACgkQOeye3VZi
gbkk9hAAlZ/Sh/LCQqTCvXa7m8mRkn4CeveeU1QfCraSb5bX3U/1DqHa1LwyXw5X
fnhK7Q5VWukUt6FmLJ3Zp8FArDe/1JUt3/3lMRK5lDqhVb0CQGqZqGS/PpUDLA74
TXpsjQgVPOwMINN2CK2jnPMIlnNkq8i5sVi7UqOqRLmS8ehXQNt0OZhFZ9Zl6bFv
LGQIJ2JwL2ePmcfBU2/VaRPjM34tQLXiazw64pzm3wlK+qQxi3tq9HZtgFxMkpJW
Kg3rnGDvRF3g0hIsvZUjUWf/VADm5CULWIhxOQa3Tc9T5OJmqzZ7HXsvkJwKZ4Zs
mg7j0zjPHC8Py/C0ZzKSPYtrNfl9O9w4Y3K7vxeNjHohCcR7rRJ2JjRpddLlf6xy
ZQTLuAXUkaVunlXaF+q2sSzOyVzdbWwXdPcfy9xRCWKb3/XVt40IrzMoW9GL5IiN
FI09EprcVMWDkiJqTm/SLppS2RFVSnCrUGiqoA7b82EBqMm1DD7cvGin4MNr72gK
cvz+eQGcjAO4Jvrew54hcZ/MSxUoD+bAisH93ToC0V6ia1Yfx/wdrF3z9Sbw84vr
4vjbrbClrneN7d3ow6GMkRVN5txpOp1rM2qi1fj4uj/Yyt9ME7YDInvOp++ZfuOE
tfVXuprHujY4Wp3/VQul9DN5LXazoyGrYb0SG1DGuQ2hN5DWoww=
=rmeV
-----END PGP SIGNATURE-----
--=-=-=--
