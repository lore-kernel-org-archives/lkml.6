Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3841409-1519418935-2-10828200704408415236
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519418934; b=Nz58rwu4sV78M6wYNq5NevMQ7bE+qnrRn3Agqte4blgiBnO
    GSSXDS29p6tz7Sr4+cWs5eJD4dhdR3TwFgz1Wqmjvz5u2+s2sb6TX+1z4I1YFEoe
    ZTE0fpUUQsmhmxZqqClGMYI64gUB4iIWzix3dXOCkaQRyMbDwa0BX7LcZRta/S9t
    J191hiaq2FG9L6/tnWOoAUzIVwYbcj7NBhfPpLertfyZ2559gAjaKvYqHg6jkTZp
    UVeCMcn/EjpMfqrdLj9tl5rCkEYhjVZ3KP2gB+OqJRi0zPERECfgZciKVRGtHVF+
    BgYTMhTC6NTfW5XyDShyHvXE0i7j4FjoUmGzL6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519418934; bh=BA9kvzg4ROzhvU0CZwg8dqhwxG
    nhGxi/LCVePr7uPl4=; b=lRfVnPk7SECDbKj+bd292TrLHP8vB0QXFGDS5tR3VR
    l43PKQZuEcT1dlCpKMZqjFQRCE3MHPxOmohnh9v3Rgwojgl4F3qhbHxfH+IqlWSS
    M/6ZefFuUA1KH3aYu40uM+zmS/HEm1wjsqqqNvvTXppORBEoOmcIcKAqgIIm8iWe
    6q6lS28zub0bmSQOpwPeKc4DS3N5QY1O2fQCimQvNpdJsJs9LOjlOuNcWkd71I6g
    XSQfckKhLlgS6TIzNYgzruW9vE90kI6sLJ2MZiQittbk+Kr2LcPq+w8pcjvjZ30M
    IKqV7BI77HFmb6qNijs5KScOimotGEZnuSkXAtD4KFhg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752622AbeBWSbj (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:31:39 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35312 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752597AbeBWSbh (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:31:37 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH 3.18 06/58] arm: spear13xx: Fix spics gpio controllers warning
Date: Fri, 23 Feb 2018 19:26:05 +0100
Message-Id: <20180223170207.672704285@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170206.724655284@linuxfoundation.org>
References: <20180223170206.724655284@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Viresh Kumar <viresh.kumar@linaro.org>

commit f8975cb1b8a36d0839b6365235778dd9df1d04ca upstream.

This fixes the following warning by also sending the flags argument for
gpio controllers:

Property 'cs-gpios', cell 6 is not a phandle reference in
/ahb/apb/spi@e0100000

Fixes: 8113ba917dfa ("ARM: SPEAr: DT: Update device nodes")
Cc: stable@vger.kernel.org # v3.8+
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/spear1310-evb.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/spear1310-evb.dts
+++ b/arch/arm/boot/dts/spear1310-evb.dts
@@ -349,7 +349,7 @@
 			spi0: spi@e0100000 {
 				status = "okay";
 				num-cs = <3>;
-				cs-gpios = <&gpio1 7 0>, <&spics 0>, <&spics 1>;
+				cs-gpios = <&gpio1 7 0>, <&spics 0 0>, <&spics 1 0>;
 
 				stmpe610@0 {
 					compatible = "st,stmpe610";
