Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2630128-1524405816-2-820031469095890779
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
    1524405816; b=qvDJuMI3v5Oxw33KWve3zRIvPm65Q3Y7uYfIrd6YFPShdx5KJF
    PFE/Fgdr9uW7COJlj1ZlZF6gkklpp9ztFj4EWHjP+Zf/HW0lPfyqQWM+Fs5kgWkM
    7t9UZ2tpndIhRQWKQO7vsY+AyE1N692TGB4+X0jhbGum2uf5yy7N/nSabTLrqwmP
    X89z0NbSVbcu03ftwLV7+/zOjdJCuJ/+EGvnXeIAnEofYHkW9Jo8iUn1nnBFgPCL
    GN6g55YJE2OrqVc/peZOu1ogeKJQ9+BG1LQkIm+osaEaXJ1sNgaRpAyadwXbjbWz
    g2SXUstMZylOAuqhoC4ktWU9blTdJqWkDV+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524405816; bh=Amkv8cOyDhSaaIhEivNK9zXgQPUTky
    n55YfIJpfEoNA=; b=HVIxHgS3Nf9+daMEBDdSEUsZFo0vg6vHwx49gdBqzSBa2C
    UH8ZqCyDvQZouRk90Blu2u2vWGsYwgbomev6YOfJpuEDVAi5TzJKiT4sP1v9+sy1
    EOwzxKS35d+HP8CE3KoZ5/XUfN440ex0+HmvDZOVUeBN2CNBt78eYV4G+ChO4VaM
    zgXpUy6v3bmMZTVfRa5425bld/mtLgUnkKFc+wfRT1L8YqD1LSM0/tc5VNG/n6YP
    x98NLZbprQF8SDN30Dhu93teg8mRWpN0fSFEVOrG51v6NnjySsTUw3yb/Ya/uwxn
    X9sbahin2s2PIUmexn0ehX4zkb8QPnPizj+EXTZQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfC+VQqDmDmwg3TJnkrsHmAbojzh3Kp6RVOHnGh2HgOiAQktdXakFH+TJHWo1lKdCDK1fDqZcgpWEJPFWMAHpcttxdk58kH0Zi7vohSrFsGkRWkXEPe/M
    lqMkxBkyqeeMsLzaWMWYb/M/vZEykvr9R8axy4inWFNNH4ciB7qVkV20l70AYevPXummTYwd+/AQ1FkPNnAFTZnjZ3rTHPVv+lRc3s8CVI8ozCafiaZ5fsJ+
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=yPCof4ZbAAAA:8 a=DfNHnWVPAAAA:8 a=ag1SF4gXAAAA:8 a=ujiIzIQcLBR78X1VuDkA:9
    a=QEXdDO2ut3YA:10 a=rjTVMONInIDnV1a_A2c_:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755096AbeDVODd (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:03:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49274 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755067AbeDVOD2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:03:28 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Aaron Ma <aaron.ma@canonical.com>
Subject: [PATCH 4.16 195/196] HID: i2c-hid: fix inverted return value from i2c_hid_command()
Date: Sun, 22 Apr 2018 15:53:35 +0200
Message-Id: <20180422135114.373083685@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
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

From: Jiri Kosina <jkosina@suse.cz>

commit b658912cb023cd6f8e46963d29779903d3c10538 upstream.

i2c_hid_command() returns non-zero in error cases (the actual
errno). Error handling in for I2C_HID_QUIRK_RESEND_REPORT_DESCR
case in i2c_hid_resume() had the check inverted; fix that.

Fixes: 3e83eda467 ("HID: i2c-hid: Fix resume issue on Raydium touchscreen device")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Cc: Aaron Ma <aaron.ma@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/i2c-hid/i2c-hid.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -1229,7 +1229,7 @@ static int i2c_hid_resume(struct device
 	 */
 	if (ihid->quirks & I2C_HID_QUIRK_RESEND_REPORT_DESCR) {
 		ret = i2c_hid_command(client, &hid_report_descr_cmd, NULL, 0);
-		if (!ret)
+		if (ret)
 			return ret;
 	}
 
