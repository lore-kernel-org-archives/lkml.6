Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FA6C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF71C2168B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="X13HOylb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF71C2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbeI1ThM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 15:37:12 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:47090 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbeI1ThM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 15:37:12 -0400
Received: by mail-io1-f68.google.com with SMTP id y12-v6so4092584ioj.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 06:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+/WWRzjpNno0O8bWSlS6ExS3ueFw95P8A8ClENAixew=;
        b=X13HOylbDEItS8wQHfSSYsiut7zQeegUKuCK4GoJFfZEjNH8vtvi/dM+WZCVnIaXqh
         Yx1D1PYSI9hwqbmRpSYvs2vtA0Gi+OO957uvTYx0afwdwA1NmojwA5zh0hCWEbXGWsOE
         aID/tpGS21AxO8UHcZRRitMGWsVzWxxENA9KE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+/WWRzjpNno0O8bWSlS6ExS3ueFw95P8A8ClENAixew=;
        b=HA3CpHGyVTewBxCfuSe7xa8BBjF0WCgFX7rESLVYdAfc/884U7RS5weCQptjhosUhC
         GutTZrgDMWrBCyb+/AAmtAlhJrFU2g5QSpZN9Bnjd6Wfn6TCFTo5igdcqM+SjkJ0Iai4
         VvmEDM8R21Ex8cIh7T6fPpAklIxMep8fedLtMSkFQt4Yi9zTJuYM/gpguCgBomFpmSjj
         qCdidrAFD50gWsdKuv2fZte3H4tefNrg8EImJaPlyZII8kyqXjC4XvKZBdYllLg/iKmP
         K7CpehZCnFK8WqKxVQRJHRT1dCtOU1AHyutWnvNlka6H5ltJMyyJEPtcgmu+wuxBqXq7
         1pMQ==
X-Gm-Message-State: ABuFfog0Cqm5naBKVa9idrEurpGHjqZUiOJGrTdjvfkod8X/DY6N85NB
        sWuHxzP7DVbLwzVBEVu0vKvNtIwxGrfuyN3QUTy/IQ==
X-Google-Smtp-Source: ACcGV63ryAPc3JXK+2F15jutYiLXDT/OF9NFe7VqqkAOYPVe1zaGbN+2eHRvtXLNW3Oln3e6zqOOQALdc7vCEgoZ0Q8=
X-Received: by 2002:a6b:5d12:: with SMTP id r18-v6mr11582305iob.170.1538140407082;
 Fri, 28 Sep 2018 06:13:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:2848:0:0:0:0:0 with HTTP; Fri, 28 Sep 2018 06:13:26
 -0700 (PDT)
In-Reply-To: <1537351855-16618-3-git-send-email-clabbe@baylibre.com>
References: <1537351855-16618-1-git-send-email-clabbe@baylibre.com> <1537351855-16618-3-git-send-email-clabbe@baylibre.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 28 Sep 2018 15:13:26 +0200
Message-ID: <CAKv+Gu9VCZx=UHSoN7SexZeTzLK6yk9YAe5qMdhhDMUFnqTSCQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] crypto: tools: Add cryptostat userspace
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        nhorman@tuxdriver.com,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 September 2018 at 12:10, Corentin Labbe <clabbe@baylibre.com> wrote:
> This patch adds an userspace tool for displaying kernel crypto API
> statistics.
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

How do I actually build this thing?

> ---
>  tools/crypto/getstat.c | 294 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 294 insertions(+)
>  create mode 100644 tools/crypto/getstat.c
>
> diff --git a/tools/crypto/getstat.c b/tools/crypto/getstat.c
> new file mode 100644
> index 000000000000..24115173a483
> --- /dev/null
> +++ b/tools/crypto/getstat.c
> @@ -0,0 +1,294 @@
> +/* Heavily copied from libkcapi 2015 - 2017, Stephan Mueller <smueller@chronox.de> */
> +#include <errno.h>
> +#include <linux/cryptouser.h>
> +#include <linux/netlink.h>
> +#include <linux/rtnetlink.h>
> +#include <sys/types.h>
> +#include <sys/socket.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <time.h>
> +#include <unistd.h>
> +
> +#define CR_RTA(x)  ((struct rtattr *)(((char *)(x)) + NLMSG_ALIGN(sizeof(struct crypto_user_alg))))
> +
> +static int get_stat(const char *drivername)
> +{
> +       struct {
> +               struct nlmsghdr n;
> +               struct crypto_user_alg cru;
> +       } req;
> +       struct sockaddr_nl nl;
> +       int sd = 0, ret;
> +       socklen_t addr_len;
> +       struct iovec iov;
> +       struct msghdr msg;
> +       char buf[4096];
> +       struct nlmsghdr *res_n = (struct nlmsghdr *)buf;
> +       struct crypto_user_alg *cru_res = NULL;
> +       int res_len = 0;
> +       struct rtattr *tb[CRYPTOCFGA_MAX + 1];
> +       struct rtattr *rta;
> +       struct nlmsgerr *errmsg;
> +
> +       memset(&req, 0, sizeof(req));
> +       memset(&buf, 0, sizeof(buf));
> +       memset(&msg, 0, sizeof(msg));
> +
> +       req.n.nlmsg_len = NLMSG_LENGTH(sizeof(req.cru));
> +       req.n.nlmsg_flags = NLM_F_REQUEST;
> +       req.n.nlmsg_type = CRYPTO_MSG_GETSTAT;
> +       req.n.nlmsg_seq = time(NULL);
> +
> +       strncpy(req.cru.cru_driver_name, drivername, strlen(drivername));
> +
> +       sd =  socket(AF_NETLINK, SOCK_RAW, NETLINK_CRYPTO);
> +       if (sd < 0) {
> +               fprintf(stderr, "Netlink error: cannot open netlink socket");
> +               return -errno;
> +       }
> +       memset(&nl, 0, sizeof(nl));
> +       nl.nl_family = AF_NETLINK;
> +       if (bind(sd, (struct sockaddr *)&nl, sizeof(nl)) < 0) {
> +               ret = -errno;
> +               fprintf(stderr, "Netlink error: cannot bind netlink socket");
> +               goto out;
> +       }
> +
> +       /* sanity check that netlink socket was successfully opened */
> +       addr_len = sizeof(nl);
> +       if (getsockname(sd, (struct sockaddr *)&nl, &addr_len) < 0) {
> +               ret = -errno;
> +               printf("Netlink error: cannot getsockname");
> +               goto out;
> +       }
> +       if (addr_len != sizeof(nl)) {
> +               ret = -errno;
> +               printf("Netlink error: wrong address length %d", addr_len);
> +               goto out;
> +       }
> +       if (nl.nl_family != AF_NETLINK) {
> +               ret = -errno;
> +               printf("Netlink error: wrong address family %d",
> +                               nl.nl_family);
> +               goto out;
> +       }
> +
> +       memset(&nl, 0, sizeof(nl));
> +       nl.nl_family = AF_NETLINK;
> +       iov.iov_base = (void *)&req.n;
> +       iov.iov_len = req.n.nlmsg_len;
> +       msg.msg_name = &nl;
> +       msg.msg_namelen = sizeof(nl);
> +       msg.msg_iov = &iov;
> +       msg.msg_iovlen = 1;
> +       if (sendmsg(sd, &msg, 0) < 0) {
> +               ret = -errno;
> +               printf("Netlink error: sendmsg failed");
> +               goto out;
> +       }
> +       memset(buf, 0, sizeof(buf));
> +       iov.iov_base = buf;
> +       while (1) {
> +               iov.iov_len = sizeof(buf);
> +               ret = recvmsg(sd, &msg, 0);
> +               if (ret < 0) {
> +                       if (errno == EINTR || errno == EAGAIN)
> +                               continue;
> +                       ret = -errno;
> +                       printf("Netlink error: netlink receive error");
> +                       goto out;
> +               }
> +               if (ret == 0) {
> +                       ret = -errno;
> +                       printf("Netlink error: no data");
> +                       goto out;
> +               }
> +               if (ret > sizeof(buf)) {
> +                       ret = -errno;
> +                       printf("Netlink error: received too much data");
> +                       goto out;
> +               }
> +               break;
> +       }
> +
> +       ret = -EFAULT;
> +       res_len = res_n->nlmsg_len;
> +       if (res_n->nlmsg_type == NLMSG_ERROR) {
> +               errmsg = NLMSG_DATA(res_n);
> +               fprintf(stderr, "Fail with %d\n", errmsg->error);
> +               ret = errmsg->error;
> +               goto out;
> +       }
> +
> +       if (res_n->nlmsg_type == CRYPTO_MSG_GETSTAT) {
> +               cru_res = NLMSG_DATA(res_n);
> +               res_len -= NLMSG_SPACE(sizeof(*cru_res));
> +       }
> +       if (res_len < 0) {
> +               printf("Netlink error: nlmsg len %d\n", res_len);
> +               goto out;
> +       }
> +
> +       if (!cru_res) {
> +               ret = -EFAULT;
> +               printf("Netlink error: no cru_res\n");
> +               goto out;
> +       }
> +
> +       rta = CR_RTA(cru_res);
> +       memset(tb, 0, sizeof(struct rtattr *) * (CRYPTOCFGA_MAX + 1));
> +       while (RTA_OK(rta, res_len)) {
> +               if ((rta->rta_type <= CRYPTOCFGA_MAX) && (!tb[rta->rta_type]))
> +                       tb[rta->rta_type] = rta;
> +               rta = RTA_NEXT(rta, res_len);
> +       }
> +       if (res_len) {
> +               printf("Netlink error: unprocessed data %d",
> +                               res_len);
> +               goto out;
> +       }
> +
> +       if (tb[CRYPTOCFGA_STAT_HASH]) {
> +               struct rtattr *rta = tb[CRYPTOCFGA_STAT_HASH];
> +               struct crypto_stat *rhash =
> +                       (struct crypto_stat *)RTA_DATA(rta);
> +               printf("%s\tHash\n\tHash: %u bytes: %llu\n\tErrors: %u\n",
> +                       drivername,
> +                       rhash->stat_hash_cnt, rhash->stat_hash_tlen,
> +                       rhash->stat_hash_err_cnt);
> +       } else if (tb[CRYPTOCFGA_STAT_COMPRESS]) {
> +               struct rtattr *rta = tb[CRYPTOCFGA_STAT_COMPRESS];
> +               struct crypto_stat *rblk =
> +                       (struct crypto_stat *)RTA_DATA(rta);
> +               printf("%s\tCompress\n\tCompress: %u bytes: %llu\n\tDecompress: %u bytes: %llu\n\tErrors: %u\n",
> +                       drivername,
> +                       rblk->stat_compress_cnt, rblk->stat_compress_tlen,
> +                       rblk->stat_decompress_cnt, rblk->stat_decompress_tlen,
> +                       rblk->stat_compress_err_cnt);
> +       } else if (tb[CRYPTOCFGA_STAT_ACOMP]) {
> +               struct rtattr *rta = tb[CRYPTOCFGA_STAT_ACOMP];
> +               struct crypto_stat *rcomp =
> +                       (struct crypto_stat *)RTA_DATA(rta);
> +               printf("%s\tACompress\n\tCompress: %u bytes: %llu\n\tDecompress: %u bytes: %llu\n\tErrors: %u\n",
> +                       drivername,
> +                       rcomp->stat_compress_cnt, rcomp->stat_compress_tlen,
> +                       rcomp->stat_decompress_cnt, rcomp->stat_decompress_tlen,
> +                       rcomp->stat_compress_err_cnt);
> +       } else if (tb[CRYPTOCFGA_STAT_AEAD]) {
> +               struct rtattr *rta = tb[CRYPTOCFGA_STAT_AEAD];
> +               struct crypto_stat *raead =
> +                       (struct crypto_stat *)RTA_DATA(rta);
> +               printf("%s\tAEAD\n\tEncrypt: %u bytes: %llu\n\tDecrypt: %u bytes: %llu\n\tErrors: %u\n",
> +                       drivername,
> +                       raead->stat_encrypt_cnt, raead->stat_encrypt_tlen,
> +                       raead->stat_decrypt_cnt, raead->stat_decrypt_tlen,
> +                       raead->stat_aead_err_cnt);
> +       } else if (tb[CRYPTOCFGA_STAT_BLKCIPHER]) {
> +               struct rtattr *rta = tb[CRYPTOCFGA_STAT_BLKCIPHER];
> +               struct crypto_stat *rblk =
> +                       (struct crypto_stat *)RTA_DATA(rta);
> +               printf("%s\tCipher\n\tEncrypt: %u bytes: %llu\n\tDecrypt: %u bytes: %llu\n\tErrors: %u\n",
> +                       drivername,
> +                       rblk->stat_encrypt_cnt, rblk->stat_encrypt_tlen,
> +                       rblk->stat_decrypt_cnt, rblk->stat_decrypt_tlen,
> +                       rblk->stat_cipher_err_cnt);
> +       } else if (tb[CRYPTOCFGA_STAT_AKCIPHER]) {
> +               struct rtattr *rta = tb[CRYPTOCFGA_STAT_AKCIPHER];
> +               struct crypto_stat *rblk =
> +                       (struct crypto_stat *)RTA_DATA(rta);
> +               printf("%s\tAkcipher\n\tEncrypt: %u bytes: %llu\n\tDecrypt: %u bytes: %llu\n\tSign: %u\n\tVerify: %u\n\tErrors: %u\n",
> +                       drivername,
> +                       rblk->stat_encrypt_cnt, rblk->stat_encrypt_tlen,
> +                       rblk->stat_decrypt_cnt, rblk->stat_decrypt_tlen,
> +                       rblk->stat_sign_cnt, rblk->stat_verify_cnt,
> +                       rblk->stat_akcipher_err_cnt);
> +       } else if (tb[CRYPTOCFGA_STAT_CIPHER]) {
> +               struct rtattr *rta = tb[CRYPTOCFGA_STAT_CIPHER];
> +               struct crypto_stat *rblk =
> +                       (struct crypto_stat *)RTA_DATA(rta);
> +               printf("%s\tcipher\n\tEncrypt: %u bytes: %llu\n\tDecrypt: %u bytes: %llu\n\tErrors: %u\n",
> +                       drivername,
> +                       rblk->stat_encrypt_cnt, rblk->stat_encrypt_tlen,
> +                       rblk->stat_decrypt_cnt, rblk->stat_decrypt_tlen,
> +                       rblk->stat_cipher_err_cnt);
> +       } else if (tb[CRYPTOCFGA_STAT_RNG]) {
> +               struct rtattr *rta = tb[CRYPTOCFGA_STAT_RNG];
> +               struct crypto_stat *rrng =
> +                       (struct crypto_stat *)RTA_DATA(rta);
> +               printf("%s\tRNG\n\tSeed: %u\n\tGenerate: %u bytes: %llu\n\tErrors: %u\n",
> +                       drivername,
> +                       rrng->stat_seed_cnt,
> +                       rrng->stat_generate_cnt, rrng->stat_generate_tlen,
> +                       rrng->stat_rng_err_cnt);
> +       } else if (tb[CRYPTOCFGA_STAT_KPP]) {
> +               struct rtattr *rta = tb[CRYPTOCFGA_STAT_KPP];
> +               struct crypto_stat *rkpp =
> +                       (struct crypto_stat *)RTA_DATA(rta);
> +               printf("%s\tKPP\n\tSetsecret: %u\n\tGenerate public key: %u\n\tCompute_shared_secret: %u\n\tErrors: %u\n",
> +                       drivername,
> +                       rkpp->stat_setsecret_cnt,
> +                       rkpp->stat_generate_public_key_cnt,
> +                       rkpp->stat_compute_shared_secret_cnt,
> +                       rkpp->stat_kpp_err_cnt);
> +       } else {
> +               fprintf(stderr, "%s is of an unknown algorithm\n", drivername);
> +       }
> +       ret = 0;
> +out:
> +       close(sd);
> +       return ret;
> +}
> +
> +int main(int argc, const char *argv[])
> +{
> +       char buf[4096];
> +       FILE *procfd;
> +       int i, lastspace;
> +       int ret;
> +
> +       procfd = fopen("/proc/crypto", "r");
> +       if (!procfd) {
> +               ret = errno;
> +               fprintf(stderr, "Cannot open /proc/crypto %s\n", strerror(errno));
> +               return ret;
> +       }
> +       if (argc > 1) {
> +               if (!strcmp(argv[1], "-h") || !strcmp(argv[1], "--help")) {
> +                       printf("Usage: %s [-h|--help] display this help\n", argv[0]);
> +                       printf("Usage: %s display all crypto statistics\n", argv[0]);
> +                       printf("Usage: %s drivername1 drivername2 ... = display crypto statistics about drivername1 ...\n", argv[0]);
> +                       return 0;
> +               }
> +               for (i = 1; i < argc; i++) {
> +                       ret = get_stat(argv[i]);
> +                       if (ret) {
> +                               fprintf(stderr, "Failed with %s\n", strerror(-ret));
> +                               return ret;
> +                       }
> +               }
> +               return 0;
> +       }
> +
> +       while (fgets(buf, sizeof(buf), procfd)) {
> +               if (!strncmp(buf, "driver", 6)) {
> +                       lastspace = 0;
> +                       i = 0;
> +                       while (i < strlen(buf)) {
> +                               i++;
> +                               if (buf[i] == ' ')
> +                                       lastspace = i;
> +                       }
> +                       buf[strlen(buf) - 1] = '\0';
> +                       ret = get_stat(buf + lastspace + 1);
> +                       if (ret) {
> +                               fprintf(stderr, "Failed with %s\n", strerror(-ret));
> +                               goto out;
> +                       }
> +               }
> +       }
> +out:
> +       fclose(procfd);
> +       return ret;
> +}
> --
> 2.16.4
>
