Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1405515-1526333112-2-8588022628596658400
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526333112; b=CJX3klBevjZSeJ+XSmfNP6KPc+SUt3sPH1osLuuE4TaChl7P1W
    fJE8tJV+os+NvTTTWelmeesxO7qx9itGmW9TJ6UP/kp01CaxIpa/nNI01Ro1yDqr
    QuukzoaVKxVOUY8DN71M0VlLKarzB1B9/4KpFdDCwFmt9FOJrT2dI/u5B2DZ1dzq
    Pzg6hccENLvnZmRjrGDfT4hMCRV1lrvcuTx4aeTSBp6eBtqV9yGKAhNcYiUmmhki
    diNrhPVTjVhodKelfYgaP0yo4mCpLokyyFQHpG2Bev78JxhEkousrcLnXIEbUP4/
    G1dccqlM0uHk2OtvzMAJQF4obdLwY7tCDjrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526333112; bh=8h0nb
    PPoHEgtnJQXPqpsmVfx4ibLjONdx1WVP/1zqS4=; b=AyJTTI5EoGOkIfBKPtqK0
    X5AWTurrCwQ78kYqcc9lVfY1+4QSs3YNuMb4ZRXsi4KHqPs0Zxvit5zHFojMdopo
    DDrs/Gxb0BEterR2UdsTNDRYWDGg+QK+N7zf/03mxObG+yk2G/tTlI3A+W88+ND7
    yekghohCdbuqDhBlm+STWsjFE3x4XzYyb808GTTeXWQMw5t7z1LrH2a3EnWbINEX
    q4JuuJXhSOWTZpfBuVLM1Vy0ll4YcDbCn/KBuensbiYt+h1RRLAPMjWO3na44i5l
    hDJwIfNM7Hz5avwDeXKQWzaaB0Zl5SdWtvlNhtOFNHwGD1OLdRZXakLAewGW+MVh
    w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=j/SSacTA x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=gnwXBoDP;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=j/SSacTA x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=gnwXBoDP;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAC9Wdi+DXZYfKyoX8EPgiE650m/LG3sMeYf7afHl4Z4UslrkWTOMdCAwYw1+4KPwt4RIK+ksHmkVIH20n3ii/RQpaj9ZvdxqLz606mWSuae4GwVrz1C
    wm47tqHwOllDDhymaLMWB8nYuT3qqM+79Q686VWLHcZQ/1jrTAlL7wFR8cYQtxqrQfoaTRXzT2V6UXm9y3YUwid7oitXEsXyDjZ2wPIpzrBvfd0dh2BSMjvU
    9YqfysIS/AHFYC9qc10fuw==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=A8vicNgK_FEA:10 a=kj9zAlcOel0A:10
    a=x7bEGLp0ZPQA:10 a=o_dtBaZDOvUA:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=Pqq4GbSdKCELgRsv12cA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZqK6aQ56n5xow32lYzkPOzgxv42cXFUrnvsfcEbtHg/QDTcDwUpUuAuXhe+8QY90lk64w6LEg==
From: John Whitmore <johnfwhitmore@gmail.com>
To: gregkh@linuxfoundation.org
Subject: coding style changes to
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
Date: Mon, 14 May 2018 22:24:07 +0100
Message-Id: <20180514212434.17514-1-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.16.3
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
Cc: kstewart@linuxfoundation.org, colin.king@canonical.com, tglx@linutronix.de,
 devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Second attempt at this commit, apologies for that.

Coding style changes to resolve some of the scripts/checkpatch.pl issues with
the file drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c.

There remain line length and CamelCase issues unresolved in the file.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
