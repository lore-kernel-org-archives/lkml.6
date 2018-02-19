Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932351AbeBSXxx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 18:53:53 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35850 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932275AbeBSXxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 18:53:23 -0500
X-Google-Smtp-Source: AH8x225hVYJ7/Wjpta6ZuaSa6qnokjzdm6YI+1QRoWy/LaVolbZ/IP/jOif1dHEOas0gJAPBScTcLQ==
From: Kees Cook <keescook@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v2 0/3] taint: Add taint for randstruct
Date: Mon, 19 Feb 2018 15:53:07 -0800
Message-Id: <1519084390-43867-1-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This cleans up the taint flags and documentation before adding a new
one for randstruct. This v2 reverts the #define->enum change as some
architectures include TAINT flags in assembly source, which cannot
use enums.

Patch 3/3 reads:

Since the randstruct plugin can intentionally produce extremely unusual
kernel structure layouts (even performance pathological ones), some
maintainers want to be able to trivially determine if an Oops is coming
from a randstruct-built kernel, so as to keep their sanity when debugging.
This adds the new flag and initializes taint_mask immediately when built
with randstruct.

Thanks,

-Kees
