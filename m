Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2479957-1525767513-2-10657890369357483642
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
    1525767512; b=LQuxWeBC0utXItlp+gIspTdnsGgcstRcrlAcyKym7Kre2eLNGg
    8c5ypnd1e/or3FfiTw3SmSnDQ3ooZxNUMheD15fKR6iRMOdXTBPz6pvyks7QBP19
    Oc2aWaVTHhialG1sMOFxllZu/rNWo4fG/qxXEFm6WN/77+H8MPCWC6ER/pBenRTK
    32FHzC9flhPsKnxMVNbHnSnUeotP9GCo41Q1A7OCs6pwBbLag1vjmBIrg34XWEvX
    KWhTE7gt0isUaPpzkJ14aewThiyB918DMM9mooBbCADLGMoM4V6/Lp06vjUlQb8a
    4HU99/UTYy9iXE/kFL+oJtaMZaExIfMnaQMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525767512; bh=/bF0cPHLUcVAnkKQz09UFFykQ+fA+4
    QAhUcZmhkq7Ws=; b=MruLnK8Jx+05QbD8tKQy+GgXqRWW+HhulmenO3MIX0I+o+
    tqPp84anpP8YfeX6Gyv5o8gdddNY4SoF86kc4H9noT6v+z4DX+osDcgyJbFjrfSS
    9f1sVCrDalgRWHbwoMfOKrPb2Ga49iWfLpc6pMNc+V9ZU1NlkMzAP3FNL+a279kU
    Res/zD+G0r8ZDyULuY7NBItAo8rdQqFBiSvUVj29VrkV8v/9rlRHsRkmyjnmfu1I
    rk9X5Uv91zPOlGeMQLmJKNOBGoQmqfscje+YkNrnKbcrj2zGwKjdHbaHTQ6oARm3
    SfXfQ507oVR6y9nWyN+dvrv41+RBWq1/ttz3HWhg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=ZaJ+a+md x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=ZaJ+a+md x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfMaTnea5o+RBLvfdCXe8HXQonu8tbQKb0h7XfrRM2aKEfQ4tdHmTmZAoD1QYq2GeZyn6BF5kLcxDK3sL9MUNFcC2IYxdYFO9HrJ3yaYYSDU91SAhMH+l
    JQs8j0LBKRuoUAnj4iwLLDV/leplFBFYMbt7prf8FdCvi4EG/3zKDqaR9JJp79zqlMDiVDDVq+gPKCMu6BCPQez9I35VQ3gkHnz6Cfz7vdkb5IwTTQ5QpMAF
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=1EsaE_6oAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=0gpIwUixcRr1avNuft0A:9
    a=hWusq4ecZzsTxdkz:21 a=NczbeVWSBY4agPSk:21 a=QEXdDO2ut3YA:10
    a=3ZumFrijQQ-2J9H5h8ct:22 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933065AbeEHISI (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 04:18:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932999AbeEHISG (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 8 May 2018 04:18:06 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH 4.9 24/32] test_firmware: fix setting old custom fw path back on exit, second try
Date: Tue,  8 May 2018 10:11:04 +0200
Message-Id: <20180508074012.770557266@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074008.800421598@linuxfoundation.org>
References: <20180508074008.800421598@linuxfoundation.org>
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

From: Ben Hutchings <ben.hutchings@codethink.co.uk>

commit e538409257d0217a9bc715686100a5328db75a15 upstream.

Commit 65c79230576 tried to clear the custom firmware path on exit by
writing a single space to the firmware_class.path parameter.  This
doesn't work because nothing strips this space from the value stored
and fw_get_filesystem_firmware() only ignores zero-length paths.

Instead, write a null byte.

Fixes: 0a8adf58475 ("test: add firmware_class loader test")
Fixes: 65c79230576 ("test_firmware: fix setting old custom fw path back on exit")
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Acked-by: Luis R. Rodriguez <mcgrof@kernel.org>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 tools/testing/selftests/firmware/fw_filesystem.sh |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/tools/testing/selftests/firmware/fw_filesystem.sh
+++ b/tools/testing/selftests/firmware/fw_filesystem.sh
@@ -29,9 +29,11 @@ test_finish()
 		echo "$OLD_TIMEOUT" >/sys/class/firmware/timeout
 	fi
 	if [ "$OLD_FWPATH" = "" ]; then
-		OLD_FWPATH=" "
+		# A zero-length write won't work; write a null byte
+		printf '\000' >/sys/module/firmware_class/parameters/path
+	else
+		echo -n "$OLD_FWPATH" >/sys/module/firmware_class/parameters/path
 	fi
-	echo -n "$OLD_FWPATH" >/sys/module/firmware_class/parameters/path
 	rm -f "$FW"
 	rmdir "$FWPATH"
 }
