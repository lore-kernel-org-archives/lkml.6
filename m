Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-298528-1524839416-5-9637968449555213134
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524839416; b=YpJ0iJE9m65Uq3oDEnr3sJVfVbTUCa6mFTmZYs0XTSKKlCH8LP
    w2cDDHcGGbYFnFTT+hVYNwACbSDqToJWbS3/7fZdvkX3yD1xLabTuaweoH9cSll5
    MPy/JSayGYUOjuUXIpmKn1cifvz7ohDRY8jnvyD4NXZaLijqBZikIGm81qecMh18
    WPj1nBjwfYhLjQXkX0Bq60RSScmIgSDe+44lPgBu7kZB5z6mwEye1RhdDc857XoQ
    +GYZm9JDXiOMgOlutaOYODkVvyMSm6DKJTkJ1aapTasJnTB40IMTcpxeFxaSPCCY
    6A66rx3Ezt1/Ww0HsGnQVmBCec0Xc/8IfEYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524839416; bh=MnklLWmgRFfGfE/4Wol0Z6w7UFTHzE
    qYzYcZq3KXo+0=; b=kswFCFHoAqcbhUj/kC7BDGhcVhk0NaRswA8l/lndbjCXoi
    uMCitBsgZremaLXcqG3lzx2pxi0iPz9XfJjGCSpD0z9z4lKjTaTAgBWRLPX9S8EC
    FzofzSQ2qHj4F8jWUhAypM3zREj7Q0b5ojMUW7M1poHZ3zPWXzsEAKF7u3ngkqM3
    wAS0xyFWYEKj3FzH+ja9IKlL+JMENavPptjsII9t4p0VNJmwQ9wQMHCM9b+zoEr7
    nwxj0jw8lI7+VpScCzB1nyb7qQQnd6VlkVtYTivwPgWHeRN6WDfi6Gb7LwQgAi3h
    nfwn05yZLEIZvNiq0rb/mdA28c3QuBx0HmfBXUKw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHUu24I3QukggVgjIUo24jch961XzD7zvvjE+lhPFmwn0BbcUaPhz15tNiGa60APWVfTGud+sNESzc/F13txpr+ccQ6RVfG1SXKde2N9DwYcf9sUoHlG
    IjoSci9nRE5cs6UEuywSoisEtrsqPePuuIwXHHHTWAjTZwnzksGyBtWEq0jIpeVjk4sCPCBA3gaYK4Zr3eVIpA/BiwOeCaM5sfOugj6CeexAt5Dfytg9/FCF
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=s69QxFRhAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=572aw6MZ-aO4NtqmRjgA:9
    a=vuQKtNYfoVCEpe09:21 a=y6uC6XJbNsGZyPhR:21 a=QEXdDO2ut3YA:10
    a=FzsZaHqyxIPyk0jfoVVe:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934768AbeD0O34 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:29:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:55972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934799AbeD0OLD (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:11:03 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E2832189E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Olivier Gayot <olivier.gayot@sigexec.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 09/81] docs: ip-sysctl.txt: fix name of some ipv6 variables
Date: Fri, 27 Apr 2018 15:58:11 +0200
Message-Id: <20180427135743.747605475@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Olivier Gayot <olivier.gayot@sigexec.com>


[ Upstream commit ab913455dd59b81204b6a0d387a44697b0e0bd85 ]

The name of the following proc/sysctl entries were incorrectly
documented:

    /proc/sys/net/ipv6/conf/<interface>/max_dst_opts_number
    /proc/sys/net/ipv6/conf/<interface>/max_hbt_opts_number
    /proc/sys/net/ipv6/conf/<interface>/max_dst_opts_length
    /proc/sys/net/ipv6/conf/<interface>/max_hbt_length

Their name was set to the name of the symbol in the .data field of the
control table instead of their .proc name.

Signed-off-by: Olivier Gayot <olivier.gayot@sigexec.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/networking/ip-sysctl.txt |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/Documentation/networking/ip-sysctl.txt
+++ b/Documentation/networking/ip-sysctl.txt
@@ -1386,26 +1386,26 @@ mld_qrv - INTEGER
 	Default: 2 (as specified by RFC3810 9.1)
 	Minimum: 1 (as specified by RFC6636 4.5)
 
-max_dst_opts_cnt - INTEGER
+max_dst_opts_number - INTEGER
 	Maximum number of non-padding TLVs allowed in a Destination
 	options extension header. If this value is less than zero
 	then unknown options are disallowed and the number of known
 	TLVs allowed is the absolute value of this number.
 	Default: 8
 
-max_hbh_opts_cnt - INTEGER
+max_hbh_opts_number - INTEGER
 	Maximum number of non-padding TLVs allowed in a Hop-by-Hop
 	options extension header. If this value is less than zero
 	then unknown options are disallowed and the number of known
 	TLVs allowed is the absolute value of this number.
 	Default: 8
 
-max dst_opts_len - INTEGER
+max_dst_opts_length - INTEGER
 	Maximum length allowed for a Destination options extension
 	header.
 	Default: INT_MAX (unlimited)
 
-max hbh_opts_len - INTEGER
+max_hbh_length - INTEGER
 	Maximum length allowed for a Hop-by-Hop options extension
 	header.
 	Default: INT_MAX (unlimited)
