Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933358AbeEIAmo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 20:42:44 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:42215 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933134AbeEIAml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 20:42:41 -0400
X-Google-Smtp-Source: AB8JxZoViXihP+1lIyQadqdnwtgbCI8TLUnusvfZkrQpqWD8Mz1s3I9rvOEuIbuu8dgPBIjDR0N1AA==
From: Kees Cook <keescook@chromium.org>
To: Matthew Wilcox <mawilcox@microsoft.com>
Cc: Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-hardening@lists.openwall.com
Subject: [RFC][PATCH 00/13] Provide saturating helpers for allocation
Date: Tue,  8 May 2018 17:42:16 -0700
Message-Id: <20180509004229.36341-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a stab at providing three new helpers for allocation size
calculation:

struct_size(), array_size(), and array3_size().

These are implemented on top of Rasmus's overflow checking functions,
and the last 8 patches are all treewide conversions of open-coded
multiplications into the various combinations of the helper functions.

-Kees
