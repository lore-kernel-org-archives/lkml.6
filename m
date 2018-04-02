Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756559AbeDBUHe convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 16:07:34 -0400
Received: from elephants.elehost.com ([216.66.27.132]:61838 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755445AbeDBUHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 16:07:33 -0400
From: "Randall S. Becker" <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
Cc: "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
        <git-packagers@googlegroups.com>
References: <xmqq6059z9kz.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq6059z9kz.fsf@gitster-ct.c.googlers.com>
Subject: RE: [ANNOUNCE] Git v2.17.0
Date: Mon, 2 Apr 2018 15:57:52 -0400
Message-ID: <014501d3cabc$e5f22370$b1d66a50$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFhLuUQLx28uJBqsgyhh0QfTRDAYKTTGywA
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On April 2, 2018 3:34 PM, Junio C Hamano wrote:
> The latest feature release Git v2.17.0 is now available at the usual places.  It is
> comprised of 516 non-merge commits since v2.16.0, contributed by 71
> people, 20 of which are new faces.

Just a heads up. I think this one might have gotten missed at some point a few months back. I think it was submitted back in January. Not sure where it fell off or whether it was just dropped.

diff --git a/transport-helper.c b/transport-helper.c
index 3f380d87d..5ee7007f6 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1212,7 +1212,7 @@ static int udt_do_read(struct unidirectional_transfer *t)
                return 0;       /* No space for more. */

        transfer_debug("%s is readable", t->src_name);
-       bytes = read(t->src, t->buf + t->bufuse, BUFFERSIZE - t->bufuse);
+       bytes = xread(t->src, t->buf + t->bufuse, BUFFERSIZE - t->bufuse);
        if (bytes < 0 && errno != EWOULDBLOCK && errno != EAGAIN &&
                errno != EINTR) {
                error_errno("read(%s) failed", t->src_name);

Cheers,
Randall
