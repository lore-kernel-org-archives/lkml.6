Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1886372-1527163480-2-1156423170177280788
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527163479; b=X8xMyV1GIPXMJEhq3A8oSFrJyAfLLaae5eadKEiaaybuWRDV+0
    PlCqCGZDrl6GGO9KfegIc9Ke2FC8kaeaz9brCY5ritsfniNspfUNFFLr6XZkdrDM
    jnrFdGYrvsXEQAiHtWe9FBulOOWLhlqjSCsiQNRfse56QK7kFeWGCtKsPCpdE95E
    89AUxEqhpxy6lIr8c1Ksza8WmEqeikkwP9lPP0y5N8Hd9rEAXvKyW9WY7c41/IQp
    vNUMf640cBtrVJdead1eTrmPWUTVxyQuY5s2Tj5vK8sRHBj8j0MdgsPATpC7I0ny
    XztSZUrAcHyUi1CRvBwsuAd0md7FzVgc+xLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527163479; bh=li9NQmD01U39zT9x9y3dyITrt/ePb4
    zl+VZb634c46A=; b=XvaLuOrGbUSsRa/VlUbtf+XdiPeAH8OF9l/k63ViJgnRqI
    VUGgzMdr1skj/0KF+P8fqRJNAXl8aYklSxSkww0VhkmEp8DhIKQgnKQfxmSiO3ua
    1hkabrG955eaNbfAcIOQ2k92CSmwOVnomKqrbciHPP65gDRx/jAX93w1ZQNIie+A
    uFNrC42mfdgYuZX3jiY/BqYkGoVk06Uzrfe7yiD5pYYKYJ8cKoMtpW1I1Gpf15r5
    sDNK5Tge6ousD5WAI+9l9SVE1H9s6KOaRcW9ZPSR5SpD3mJsxtQd3jJprpLR/NOP
    2K00iqM2j+ftRWwPklTyJPVuRf8EuEKfdi26cjVA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=19BmGqNz x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=19BmGqNz x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLzv9Qz+va639mejI8AGiOoctS3+Hk+cF5V07mrrJEZbP04tskMXKbVWavsBTEzg0nrPY67RTwa6cxJ8h2KqipKAhDYMeF9kkmUp884log9NTvbJPBou
    j9G0jh4mnwhqbdKNK5C4wYiv+Cx3ZAe2RirGCdEo3zGiHAWMMzGz+ar2yypF+q6cc0fJ7kOJ/pLPHKrFMis6KRfZ3heaI4uAE59gI/SG5gH23PyYLZDSi0+l
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=VliqgAhr-v1-EyMVYEYA:9
    a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966659AbeEXJoc (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:44:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:55774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966655AbeEXJoa (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:44:30 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gopal RajagopalSai <gopalsr83@gmail.com>,
        Lance Richardson <lance.richardson.net@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 09/92] net: support compat 64-bit time in {s,g}etsockopt
Date: Thu, 24 May 2018 11:37:46 +0200
Message-Id: <20180524093200.123957806@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lance Richardson <lance.richardson.net@gmail.com>

[ Upstream commit 988bf7243e03ef69238381594e0334a79cef74a6 ]

For the x32 ABI, struct timeval has two 64-bit fields. However
the kernel currently interprets the user-space values used for
the SO_RCVTIMEO and SO_SNDTIMEO socket options as having a pair
of 32-bit fields.

When the seconds portion of the requested timeout is less than 2**32,
the seconds portion of the effective timeout is correct but the
microseconds portion is zero.  When the seconds portion of the
requested timeout is zero and the microseconds portion is non-zero,
the kernel interprets the timeout as zero (never timeout).

Fix by using 64-bit time for SO_RCVTIMEO/SO_SNDTIMEO as required
for the ABI.

The code included below demonstrates the problem.

Results before patch:
    $ gcc -m64 -Wall -O2 -o socktmo socktmo.c && ./socktmo
    recv time: 2.008181 seconds
    send time: 2.015985 seconds

    $ gcc -m32 -Wall -O2 -o socktmo socktmo.c && ./socktmo
    recv time: 2.016763 seconds
    send time: 2.016062 seconds

    $ gcc -mx32 -Wall -O2 -o socktmo socktmo.c && ./socktmo
    recv time: 1.007239 seconds
    send time: 1.023890 seconds

Results after patch:
    $ gcc -m64 -O2 -Wall -o socktmo socktmo.c && ./socktmo
    recv time: 2.010062 seconds
    send time: 2.015836 seconds

    $ gcc -m32 -O2 -Wall -o socktmo socktmo.c && ./socktmo
    recv time: 2.013974 seconds
    send time: 2.015981 seconds

    $ gcc -mx32 -O2 -Wall -o socktmo socktmo.c && ./socktmo
    recv time: 2.030257 seconds
    send time: 2.013383 seconds

 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/socket.h>
 #include <sys/types.h>
 #include <sys/time.h>

 void checkrc(char *str, int rc)
 {
         if (rc >= 0)
                 return;

         perror(str);
         exit(1);
 }

 static char buf[1024];
 int main(int argc, char **argv)
 {
         int rc;
         int socks[2];
         struct timeval tv;
         struct timeval start, end, delta;

         rc = socketpair(AF_UNIX, SOCK_STREAM, 0, socks);
         checkrc("socketpair", rc);

         /* set timeout to 1.999999 seconds */
         tv.tv_sec = 1;
         tv.tv_usec = 999999;
         rc = setsockopt(socks[0], SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof tv);
         rc = setsockopt(socks[0], SOL_SOCKET, SO_SNDTIMEO, &tv, sizeof tv);
         checkrc("setsockopt", rc);

         /* measure actual receive timeout */
         gettimeofday(&start, NULL);
         rc = recv(socks[0], buf, sizeof buf, 0);
         gettimeofday(&end, NULL);
         timersub(&end, &start, &delta);

         printf("recv time: %ld.%06ld seconds\n",
                (long)delta.tv_sec, (long)delta.tv_usec);

         /* fill send buffer */
         do {
                 rc = send(socks[0], buf, sizeof buf, 0);
         } while (rc > 0);

         /* measure actual send timeout */
         gettimeofday(&start, NULL);
         rc = send(socks[0], buf, sizeof buf, 0);
         gettimeofday(&end, NULL);
         timersub(&end, &start, &delta);

         printf("send time: %ld.%06ld seconds\n",
                (long)delta.tv_sec, (long)delta.tv_usec);
         exit(0);
 }

Fixes: 515c7af85ed9 ("x32: Use compat shims for {g,s}etsockopt")
Reported-by: Gopal RajagopalSai <gopalsr83@gmail.com>
Signed-off-by: Lance Richardson <lance.richardson.net@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/compat.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/net/compat.c
+++ b/net/compat.c
@@ -358,7 +358,8 @@ static int compat_sock_setsockopt(struct
 	if (optname == SO_ATTACH_FILTER)
 		return do_set_attach_filter(sock, level, optname,
 					    optval, optlen);
-	if (optname == SO_RCVTIMEO || optname == SO_SNDTIMEO)
+	if (!COMPAT_USE_64BIT_TIME &&
+	    (optname == SO_RCVTIMEO || optname == SO_SNDTIMEO))
 		return do_set_sock_timeout(sock, level, optname, optval, optlen);
 
 	return sock_setsockopt(sock, level, optname, optval, optlen);
@@ -423,7 +424,8 @@ static int do_get_sock_timeout(struct so
 static int compat_sock_getsockopt(struct socket *sock, int level, int optname,
 				char __user *optval, int __user *optlen)
 {
-	if (optname == SO_RCVTIMEO || optname == SO_SNDTIMEO)
+	if (!COMPAT_USE_64BIT_TIME &&
+	    (optname == SO_RCVTIMEO || optname == SO_SNDTIMEO))
 		return do_get_sock_timeout(sock, level, optname, optval, optlen);
 	return sock_getsockopt(sock, level, optname, optval, optlen);
 }
