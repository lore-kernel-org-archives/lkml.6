Return-Path: <kernelnewbies-bounces@kernelnewbies.org>
X-Cyrus-Session-Id: sloti22d1t05-26184-1517506548-2-2032637381514223465
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_NONE -0.0001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='96.67.55.147', Host='shelob.surriel.com', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: to='ISO-8859-15', plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: kernelnewbies-bounces@kernelnewbies.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517506547; b=aynFWU3foaP+IXA+dUOCzbcCgTO9f8BHbXcL8W9vW6w0Wx1
    rDu+OudSqFDT4wYXuTSuvacdre0dkOJ6BLN5SxUuVQ4Y5zWDylW2Qbj45Zr83lo6
    uHrU7AfyYLu43Fk+zzocWh25mo+aypylZ6czKLMq7uquyqtfOqoZL80EoIWdl0vS
    F3o94t5ThvBsmDJFG2HrWAg84HOi0tjoZGORbiKZIQXdNJwRv6GQCacA5LSI6qRO
    OpquIpLvmie4PJm325uMebT29rV5bDjIf/+KcY93w3qG4qQC5vlnulpg7IO8KG0b
    /TsqRr8z9iXhCtlS+y2srXk7Ja8DK63Oxg9S/Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:date:to:subject:message-id
    :mime-version:content-type:content-id:cc:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe; s=arctest; t=1517506547; bh=WUbip/lF0ToB03rGuOM
    XD/OBpsCVAtkV5VLxAfYz50U=; b=jxyvSRBjfPhQgo6bNySUysaCacwIWsR0Hu3
    9001QErzQk0TFMpWVJfpZ+jsOR+W069exsyGqvFU8EQUSPAvlY5XuJa9H8XSeI0G
    xVZi51HdWkQF/5C+E6oik+M7aVywUXoIa+34Co3LaqQXKBlCerWn4quIYf6f/2oH
    A0UAKLpHJH3G97RIotka/Hvv45gHACOJui4Pq5JLxfJcs3UqiZ09wQ2xsa3UIoPi
    N+xJ1T1bXydWFEJ4bc9iYozW62pu+8IM7mtbzY3fSOHOrXiDg4/eoyg1R1T5CFcy
    X24UeckFoaL//qf0hQIBqKhGv+DUF8JFpWfqPNlkyVhk/rWRelQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=kPPZej5r x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=96.67.55.147 (shelob.surriel.com);
    spf=permerror smtp.mailfrom=kernelnewbies-bounces@kernelnewbies.org smtp.helo=shelob.surriel.com;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TyPlaJnQ;
    x-ptr=pass x-ptr-helo=shelob.surriel.com x-ptr-lookup=shelob.surriel.com;
    x-return-mx=pass smtp.domain=kernelnewbies.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=kPPZej5r x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=96.67.55.147 (shelob.surriel.com);
    spf=permerror smtp.mailfrom=kernelnewbies-bounces@kernelnewbies.org smtp.helo=shelob.surriel.com;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TyPlaJnQ;
    x-ptr=pass x-ptr-helo=shelob.surriel.com x-ptr-lookup=shelob.surriel.com;
    x-return-mx=pass smtp.domain=kernelnewbies.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x224qUFOXPpUmTvdSmCRqUUf9dn5xJ/fJFyCW4y814UMgDRw0JseXhv6l6PJeDBWXteJb4LCIYQ==
From: Ozan Alpay <ozyalpy@gmail.com>
X-Google-Original-From: Ozan Alpay <ozan@alpaca>
Date: Thu, 1 Feb 2018 18:33:30 +0100 (CET)
To: Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?ISO-8859-15?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: clang warning: implicit conversion in intel_ddi.c:1481
Message-ID: <alpine.DEB.2.20.1802011823340.4316@alpaca>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-607598800-1517497236=:4643"
Content-ID: <alpine.DEB.2.20.1802011823341.4316@alpaca>
Cc: sil2review@lists.osadl.org, kernelnewbies@kernelnewbies.org,
 David Airlie <airlied@linux.ie>, intel-gfx@lists.freedesktop.org,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 llvmlinux@lists.linuxfoundation.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>,
 lukas.bulwahn@gmail.com
X-BeenThere: kernelnewbies@kernelnewbies.org
X-Mailman-Version: 2.1.15
List-Unsubscribe: <https://lists.kernelnewbies.org/mailman/options/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=unsubscribe>
List-Archive: <http://lists.kernelnewbies.org/pipermail/kernelnewbies/>
List-Post: <mailto:kernelnewbies@kernelnewbies.org>
List-Help: <mailto:kernelnewbies-request@kernelnewbies.org?subject=help>
List-Subscribe: <https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=subscribe>
Errors-To: kernelnewbies-bounces@kernelnewbies.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-607598800-1517497236=:4643
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.20.1802011823342.4316@alpaca>

Dear Rodrigo Vivi, Ville Syrjälä,

My name is Ozan Alpay, and I am a student mentored by Lukas Bulwahn. We 
intend to use static analysis tools on the kernel source to identify, 
analyze and report issues. As a very first step, we are looking into 
clang compiler warnings and will then move to more sophisticated tools. 

When compiling Linux 4.15 with clang, we have discovered that your commit 
2952cd6fb4cc ("drm/i915: Let's use more enum intel_dpll_id pll_id.") 
introduced the following warning:

drivers/gpu/drm/i915/intel_ddi.c:1481:30: warning: implicit conversion from enumeration type 'enum port' to different enumeration type 'enum intel_dpll_id' [-Wenum-conversion] 
	enum intel_dpll_id pll_id = port;

To reproduce it, you can compile Linux 4.15 with clang with this command: 

make HOSTCC=clang-5.0 defconfig && make -j32 HOSTCC=clang-5.0 CC=clang-5.0

If you don't have clang installed in your system, you can use this simple 
docker setup to compile the kernel with clang:

wget https://raw.githubusercontent.com/bulwahn/linux-kernel-analysis/master/docker/kernel-clang/Dockerfile && \
docker build -t kernel-clang . && \
docker run -v <your kernel source directory>:/linux/ kernel-clang /bin/sh -c "cd linux && make CC=clang-5.0 clean && make HOSTCC=clang-5.0 defconfig && make -j32 HOSTCC=clang-5.0 CC=clang-5.0"
 
While we were doing our analysis on 4.15, we noticed that you already 
resolved this warning on linux-next with your work in commit bb911536f07e 
("drm/i915: Eliminate pll->state usage from bxt_calc_pll_link()"). So, 
since it is resolved on linux-next and we expect that this commit will be 
merged in the merge window for 4.16, there is probably nothing further to 
do.

Linux 4.15 is shipped with this clang warning, but we don't see the 
crucial need to provide a backport commit to the stable branch for 4.15. 
We just wanted to inform you about our analysis of this clang warning. 
Ultimately the final call if you would like to address this clang warning 
in 4.15 is yours.

Best regards,

Ozan & Lukas
--8323329-607598800-1517497236=:4643
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Kernelnewbies mailing list
Kernelnewbies@kernelnewbies.org
https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies

--8323329-607598800-1517497236=:4643--
