Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1340521-1526937375-2-17424010329255381783
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526937375; b=ju93fHhUE4ODx6ZztQSu6UaVIPTh+mFRaYcUqYqGtm3jHFQzt7
    M+16eZW8ppVTjEhfXaj9IwvsEhrPn/sGSNbq3sQVaijLPA/r/wA4HVuIUUGrE8vw
    t0By5upAxPBBm4+oPWT7rSlBjhgW12Ii4zQIon4q0aTr0EWvKI/ax6uu6rMD+Z9P
    3/97MkJ2zRvlGQz+OADjVDt/SKs1hQEEND4E1HmwKd6k0zwkrPgb/pViIN6+PhNd
    FTvjj5eTchrlS97rlpnsvCXrxg1NBj8Zkr3JYgtW1aJ7CMCZ665QIEs8gk2CSS48
    gwvwZfF8OD/TgVt9WSPadJCF8hyhcflZTRSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526937375; bh=nYSEqTvQJi9F0Gt4FXkPrrdIa4Q8jQ
    VVW22d8i6W/lQ=; b=iEyt3vYf2PIoo0cuEJnD+DnKkhtmzFm4Y8wK96iU84rU5F
    j1Q2OJkmcVmYOLhXwB1IuPe7h8lJr5H7+3cN5Qy4tHiCiXsePJJWhUnUVNINySEj
    Yr+db4PH08RIyNIdSzGpbfEjbAHxZcQaHHUJ6jHsqmgxx/E89AViHqP7But1M+UC
    xyECTMeufj/vSj7Z5xRtIPCJPnQzwzQC5IYqXD6Yd6p7513BpKpwSThLdmBksoDD
    OWaQobRQMqtC7rjJOolT6b6ay91guqpg4BkeJ8VSgpkIzV4hD5URu4yzZL9L1Q2R
    ewx0iNWFO1KRQ4rrfUPjPo69m/296a348TROi7qw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=p3zNdQUq x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=p3zNdQUq x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfFoYW3q9cC4xpllFpFGC8+20+/3cddj5NSiTk1kKpqpzqIizD7H5koK4IbDS4sWl9ctP+p9ljPPACokYNCkefJQjZmJNiQzhgWASAsIRt6Q5ZYcGmVud
    Npat7LbXZ+ATKfmlwj+MxeIIHOLrlHqPR2/+gODSgdrsXlwzdtqax+NASK4P+AfjBImRP+wGESwX2OosaEOf15tnEgPYInlwq9DkOdqO/yR1qyavQCr5ZmKm
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=lwQ16D-4d2GxOm33qPoA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752924AbeEUVQL (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:16:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:59520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752895AbeEUVQF (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:16:05 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.9 21/87] s390/cpum_sf: ensure sample frequency of perf event attributes is non-zero
Date: Mon, 21 May 2018 23:10:57 +0200
Message-Id: <20180521210422.234521624@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hendrik Brueckner <brueckner@linux.ibm.com>

commit 4bbaf2584b86b0772413edeac22ff448f36351b1 upstream.

Correct a trinity finding for the perf_event_open() system call with
a perf event attribute structure that uses a frequency but has the
sampling frequency set to zero.  This causes a FP divide exception during
the sample rate initialization for the hardware sampling facility.

Fixes: 8c069ff4bd606 ("s390/perf: add support for the CPU-Measurement Sampling Facility")
Cc: stable@vger.kernel.org # 3.14+
Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/kernel/perf_cpum_sf.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -739,6 +739,10 @@ static int __hw_perf_event_init(struct p
 	 */
 	rate = 0;
 	if (attr->freq) {
+		if (!attr->sample_freq) {
+			err = -EINVAL;
+			goto out;
+		}
 		rate = freq_to_sample_rate(&si, attr->sample_freq);
 		rate = hw_limit_rate(&si, rate);
 		attr->freq = 0;
