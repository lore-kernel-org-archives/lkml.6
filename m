Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 9znCNiVRGVtjDQAAmS7hNA
	; Thu, 07 Jun 2018 15:38:23 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5F5676089E; Thu,  7 Jun 2018 15:38:23 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcm/KYSI"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,
	MAILING_LIST_MULTI autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E592D601B4;
	Thu,  7 Jun 2018 15:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E592D601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934785AbeFGPiU (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:38:20 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:33201 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934316AbeFGPiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:38:17 -0400
Received: by mail-io0-f196.google.com with SMTP id d185-v6so12344302ioe.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 08:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=zeEubeCMhhq6GMrUCKxAXhlQOTEx6fetESrSBU2hJPU=;
        b=gcm/KYSIyNdxvex471FbSsAtnXl1PaGvskRSYZOfGVM5tEoHOCzVQqqA6OLtIqKiM8
         APugfB1X5R/WWtvNkNvxvyOR9ayNRBhTAWnPby6jGILw7gA9MwCj6fib5VwBCE3kOskr
         p9XoopcO9mopY7KQaQ9epeGywQIY7MkjNUJ3tmyKnpacvsO5/gj1lisxGD+OeE+hzV63
         ANEkvYYncZaMB3AvbJfulgbxL1aT/TvTD5ZENkhToES4eSze8RF9joPMm94Z1GYJFHoH
         J7TQ2lZsEYKlC1E7o0dpxmRZFHAzqr6RDzNXTA+hJagOIkgjQsy2RRkNX5mExOq3CVPS
         UWHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=zeEubeCMhhq6GMrUCKxAXhlQOTEx6fetESrSBU2hJPU=;
        b=XC5aSLraX5pybBXx/sk0f32sjMQqmJfO7CpNU3CbHsjlmh2CvoXpuEFP8pBLaj9EnL
         TEmSUjhXYx2Skj5ffaH0AIfmfBBf7rPkN1w0iqhv5wZE+bJOna+LaDtlEQEzqJYy90/b
         X5sd1TT6QN0Ws8MkZwF6FoxF4Dw/C9t3KZUeyAeXZuKCgvZFQsbopHTB5R7fpzecmvEk
         WSTSz6g3EPREEnc1RvUBQEKvNpw0ANGwdq7ZTp2qnA4O5XAUqjMnRtG1pEBYpuV3+ZIq
         FQXpmxcDbBFvksGxrY0PNykaf+jHFyKhrX8RCOvoIwZaHWKo+RqVsKSzjv4cxeD6xS/v
         iSQA==
X-Gm-Message-State: APt69E14GtGG5H3JEaTjv4ZNVg8Km/Xn6ZI4nQ+tYMqKjujZUNApKev+
        3UjqJ2ho5AWKBYap/h/8+F8j8P9gkmnpy6sVZNM=
X-Google-Smtp-Source: ADUXVKLW7M8UnxTohLKj1y1LfXskxdu9ks6HccUr/JLl9oi7g2CxlX5BWYnPLhPPwANSnd3ipyn0EWR7EkLy8VHRJPY=
X-Received: by 2002:a6b:1e4d:: with SMTP id e74-v6mr2143919ioe.36.1528385897233;
 Thu, 07 Jun 2018 08:38:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:a249:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 08:38:16 -0700 (PDT)
Reply-To: sherrigallagher212@gmail.com
From: Sherri Gallagher <ahmedahme461@gmail.com>
Date: Thu, 7 Jun 2018 15:38:16 +0000
Message-ID: <CANCcr49qr-V03KzieMe6SV_4xR+hySH31zMbZMeRynxzfKm7kQ@mail.gmail.com>
Subject: 
To: undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please reply me back i have something to tell u I am Sgt.Sherri Gallagher.
