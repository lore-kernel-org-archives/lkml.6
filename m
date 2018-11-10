Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE20C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 18:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6945E20858
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 18:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwRFwIG7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6945E20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbeKKEfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 23:35:22 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43511 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbeKKEfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 23:35:22 -0500
Received: by mail-wr1-f68.google.com with SMTP id y3-v6so5155312wrh.10
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 10:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=pWThVh5cfNbHfJo9lFRyeOiCX3rKajXV9sEu9P0Kadw=;
        b=CwRFwIG7o27BkKBd7lHdBM8qmEU4uGRQ+FBTpMKI+bSOgy09ejk+/kHuYTyyWbYBzf
         DDm2u9T3y+Ol/fbNQDL6dItwFn2sBss6l0N/jidZNzjEJUtGq/bVIcYx73ojfcgFluaq
         EjS1f1i16Ykyy+B9s70iPtpf8ZSjKgCTjHW6av4sbg/LLFnpj2q/KglvQfv96KaxYreZ
         2GcuolOGCBro2wAFXi4LeDV6RzmSzTdnCoLSmSeoVJrYU2hm5wJGbfx8Mr8U4WamZoLc
         lksF6PalNbTJqkk6Ab6AZoLxOBIlFLy8ehhlAsZf+hjOMWrUIqZeFQTv70UKvKGlYyxZ
         b5hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=pWThVh5cfNbHfJo9lFRyeOiCX3rKajXV9sEu9P0Kadw=;
        b=o0ner7N0fqc5MfsxUs08VL6leV3oiWW21dlXUG9pXu+PirSW3Vaqb5OxHzF5Rl43O5
         6p9ybzBeQFQbE6YpOxTPKzv2JGiF/TsFgGAYXYddhZIyru1xLfRitZ+Zl7yXhkLMuePq
         3xMChDEP95KXdJVylPLn5cAGt5/I8ficL6UONzPLW631GBiM73nRM6mtha/aWQu2ito6
         FQWA5fN1uAflV60xG2jO/MuxwjMfTkfx3a3vd+Q8g3jNWjMCGHGq1rPRnwODXveRQVe7
         VJEjq3UWefKOxZjlzpamaatVUBps0UDPVizj18FjYAiokcBjnfpCRtr92X2yR9heymuU
         dYeQ==
X-Gm-Message-State: AGRZ1gJEb1ob3MC5s/VXl9C4yFMpYTCPIRsmCFf+/2ll0KDWVRGkqOe9
        F6K7PH1iuUKKlwaY0kYJEg==
X-Google-Smtp-Source: AJdET5cCDDL9dVG80GhQEz5UE/IfrXFxPc4a5/rdaliClLkXkntVEBIwfhvJ9XM/DsysQpdr9ELofQ==
X-Received: by 2002:a5d:64c2:: with SMTP id y2-v6mr12685130wrv.209.1541875762792;
        Sat, 10 Nov 2018 10:49:22 -0800 (PST)
Received: from avx2 (nat5-minsk-pool-46-53-217-92.telecom.by. [46.53.217.92])
        by smtp.gmail.com with ESMTPSA id h4-v6sm10440780wrt.76.2018.11.10.10.49.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Nov 2018 10:49:22 -0800 (PST)
Date:   Sat, 10 Nov 2018 21:49:20 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     rafael.tinoco@linaro.org, linux-kernel@vger.kernel.org,
        gorcunov@gmail.com
Subject: [PATCH] proc: fixup map_files test on arm
Message-ID: <20181110184920.GA18252@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

https://bugs.linaro.org/show_bug.cgi?id=3782

Turns out arm doesn't allow to map address 0, so try minimum virtual
address instead.

Reported-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 tools/testing/selftests/proc/proc-self-map-files-002.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/tools/testing/selftests/proc/proc-self-map-files-002.c
+++ b/tools/testing/selftests/proc/proc-self-map-files-002.c
@@ -13,7 +13,7 @@
  * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
  * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
-/* Test readlink /proc/self/map_files/... with address 0. */
+/* Test readlink /proc/self/map_files/... with minimum address. */
 #include <errno.h>
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -47,6 +47,11 @@ static void fail(const char *fmt, unsigned long a, unsigned long b)
 int main(void)
 {
 	const unsigned int PAGE_SIZE = sysconf(_SC_PAGESIZE);
+#ifdef __arm__
+	unsigned long va = 2 * PAGE_SIZE;
+#else
+	unsigned long va = 0;
+#endif
 	void *p;
 	int fd;
 	unsigned long a, b;
@@ -55,7 +60,7 @@ int main(void)
 	if (fd == -1)
 		return 1;
 
-	p = mmap(NULL, PAGE_SIZE, PROT_NONE, MAP_PRIVATE|MAP_FILE|MAP_FIXED, fd, 0);
+	p = mmap(va, PAGE_SIZE, PROT_NONE, MAP_PRIVATE|MAP_FILE|MAP_FIXED, fd, 0);
 	if (p == MAP_FAILED) {
 		if (errno == EPERM)
 			return 2;
