Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2930C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 19:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F01820659
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 19:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=chavero.com.mx header.i=@chavero.com.mx header.b="KOV5pD4A";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=chavero.com.mx header.i=@chavero.com.mx header.b="KOV5pD4A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F01820659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chavero.com.mx
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbeJOCoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 22:44:24 -0400
Received: from salida.aumenta.com.mx ([209.139.208.81]:40118 "EHLO
        salida.aumenta.com.mx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbeJOCoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 22:44:24 -0400
X-Greylist: delayed 580 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Oct 2018 22:44:23 EDT
Received: from localhost (localhost [127.0.0.1])
        by salida.aumenta.com.mx (Postfix) with ESMTP id 9313BC802F5;
        Sun, 14 Oct 2018 12:51:12 -0600 (MDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=chavero.com.mx;
        s=mail; t=1539543072;
        bh=19Zv/uhY7cInaHMpt/8/EvJOQldQj2t1ny47Es6YltU=;
        h=From:To:Cc:Subject:Date;
        b=KOV5pD4ACJHkob+B4q6DJTuxdzXOvpvu6PBCaNkLgBk3FQKhaZjoSuKrYo8SWPLGK
         ATIpdFG8Owe0n2jSWaUVXprYqEAvb6tUBYvxgtSb5fy3paGzJxdxz+IqAnfNguCOKu
         XkUmVrIS7FcyJ4l06vjWo96iNmCyQJY33kzS4fUM=
X-Virus-Scanned: amavisd-new at aumenta.com.mx
Received: from salida.aumenta.com.mx ([127.0.0.1])
        by localhost (trefilp.aumenta.com.mx [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id mjK6EFR0-eIP; Sun, 14 Oct 2018 12:51:12 -0600 (MDT)
Received: from sohosk8.redhat.com (unknown [189.146.207.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ichavero@seispistos.com.mx)
        by salida.aumenta.com.mx (Postfix) with ESMTPSA id 3E214C80032;
        Sun, 14 Oct 2018 12:51:11 -0600 (MDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=chavero.com.mx;
        s=mail; t=1539543072;
        bh=19Zv/uhY7cInaHMpt/8/EvJOQldQj2t1ny47Es6YltU=;
        h=From:To:Cc:Subject:Date;
        b=KOV5pD4ACJHkob+B4q6DJTuxdzXOvpvu6PBCaNkLgBk3FQKhaZjoSuKrYo8SWPLGK
         ATIpdFG8Owe0n2jSWaUVXprYqEAvb6tUBYvxgtSb5fy3paGzJxdxz+IqAnfNguCOKu
         XkUmVrIS7FcyJ4l06vjWo96iNmCyQJY33kzS4fUM=
From:   Ivan Chavero <ichavero@chavero.com.mx>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
        Ivan Chavero <ichavero@chavero.com.mx>
Subject: [PATCH] Fix Code of Conduct ambiguities
Date:   Sun, 14 Oct 2018 13:52:41 -0500
Message-Id: <20181014185241.4085197-1-ichavero@chavero.com.mx>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The language and focus of the CoC has some ambiguities that
could lead to conflicts that might distract maintainers and
contributors attention from the technical nature of the
Linux kernel.
This patch aims to clarify this problems and focus the document
to a more possitive, healthy and technical standpoint.

Signed-off-by: Ivan Chavero <ichavero@chavero.com.mx>
---
 Documentation/process/code-of-conduct.rst | 33 ++++++++++++-----------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/Documentation/process/code-of-conduct.rst b/Documentation/process/code-of-conduct.rst
index ab7c24b5478c..78d7dbe3fee3 100644
--- a/Documentation/process/code-of-conduct.rst
+++ b/Documentation/process/code-of-conduct.rst
@@ -6,10 +6,12 @@ Our Pledge
 
 In the interest of fostering an open and welcoming environment, we as
 contributors and maintainers pledge to making participation in our project and
-our community a harassment-free experience for everyone, regardless of age, body
-size, disability, ethnicity, sex characteristics, gender identity and
-expression, level of experience, education, socio-economic status, nationality,
-personal appearance, race, religion, or sexual identity and orientation.
+our community an effective and enriching experience to any sentient being
+in the Universe.
+Technical excellence should be the main focus of the community and any topics
+and discussions outside of the technical scope should not be relevant to the
+goals of the project.
+
 
 Our Standards
 =============
@@ -17,23 +19,22 @@ Our Standards
 Examples of behavior that contributes to creating a positive environment
 include:
 
-* Using welcoming and inclusive language
-* Being respectful of differing viewpoints and experiences
-* Gracefully accepting constructive criticism
-* Focusing on what is best for the community
-* Showing empathy towards other community members
+* Using welcoming and inclusive language.
+* Being respectful of differing viewpoints and experiences.
+* Gracefully accepting constructive criticism.
+* Focusing on what is best for the community.
+* Showing empathy towards other community members.
+* Use facts instead of opinions.
 
 
 Examples of unacceptable behavior by participants include:
 
-* The use of sexualized language or imagery and unwelcome sexual attention or
-  advances
-* Trolling, insulting/derogatory comments, and personal or political attacks
-* Public or private harassment
+* Public or private harassment.
 * Publishing others’ private information, such as a physical or electronic
-  address, without explicit permission
-* Other conduct which could reasonably be considered inappropriate in a
-  professional setting
+  address, without explicit permission.
+* Discussion of topics that are not relevant to the focus of the project.
+* The use of gender, racial or any other non technical argument in order
+  to win a technical debate.
 
 
 Our Responsibilities
-- 
2.17.2

