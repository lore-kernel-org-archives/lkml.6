Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECA4C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D4E20818
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pYv1E4Dd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbfBERVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 12:21:44 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36851 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfBERVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 12:21:44 -0500
Received: by mail-pg1-f194.google.com with SMTP id n2so1663533pgm.3;
        Tue, 05 Feb 2019 09:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j3GwZeGHG2UT7atC8OV1WtafbJkI0eE5rZMsh/ePfgM=;
        b=pYv1E4Dd0KXNm1eP74lwvjNyyUuHPSuCCviAPbgWYxvhOGbYoAYVzwJorsUhBNq9pm
         wOpo9okwT0KpfvFQr1Yl6SR47pqsWVp2qfdPeSyE/9/DvSeC4TjXOW1WLuqBAPULkLs/
         zLKJDQuPUXzBEobHY0gA12fB4C6raQsgRpf5FSic/x5Az1/m4gt4oSs1k45cb+AulPr8
         9aEv/i8qcsxmryFRzqVlWLCnguU7qdhd5SvA5fDVxDfKRoCHvme+zq79gLJtOWdlM9k9
         JR/y42auQE7xG7FuTyghaXNEDT/7Tklb4IoLUaJ1JwjxzisC2t5T2kiibiK0gpN+HzJ+
         7H4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j3GwZeGHG2UT7atC8OV1WtafbJkI0eE5rZMsh/ePfgM=;
        b=JJkpPkdV9EqsYZg1nXMxPL8qNn41cfJl0ZG25dV2RImdn1YoonqzKoIn9TXdKQmQ2D
         YcExt3KOPqunmPe9jAOTlzid555jvsRTSeCmT7ZhO+t8idRVMx6uTERQDBEVhDAEJkhr
         hYqIJivAkzlbQMicie7BQLQIhavBTr7Pqywkvbbx+W5yC243jbGzVa+JqmKu2TmCj8Fv
         3ezkQCNO2IK0lgwGFrdx3FOdzslFjqX+khIRNasPfpjcyroJwBTUA02NFAwvd+4bp7/w
         XvJlzqp8ryY0gix4RiXr9evVOX1iHIbtwaS83TLrja172x1RI6jiD9cCtwN6p96XH7Fo
         ICjA==
X-Gm-Message-State: AHQUAuYxyHbt2UfijSYL9eACWcXeKfzz+eDQHzNyig0z4Klf+2KtfMiv
        Cwcwb+qq5hFnOuBESP6M6tII+Nbo6RHBvCyM7Ik=
X-Google-Smtp-Source: AHgI3IYP9jivfHQ1+xzIdjjJuvJdld/570Ck/SuOlihS+0b7xPZYuQFtMjRlGNGFE3peXytTQruPqrhlzM5i9GE7H0A=
X-Received: by 2002:a63:4a21:: with SMTP id x33mr5609676pga.428.1549387303326;
 Tue, 05 Feb 2019 09:21:43 -0800 (PST)
MIME-Version: 1.0
References: <0b74e9ad12360b56bc0a3c2ca972798c424f2610.1548790896.git.lsun@mellanox.com>
 <1549054016-167128-1-git-send-email-lsun@mellanox.com>
In-Reply-To: <1549054016-167128-1-git-send-email-lsun@mellanox.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 Feb 2019 19:21:31 +0200
Message-ID: <CAHp75Vd2Rk=+CK6sR87R-2VvW8EPz7aSH8XF1_unBo6_Ww5+TQ@mail.gmail.com>
Subject: Re: [PATCH v4] platform/mellanox: Add bootctl driver for Mellanox
 BlueField Soc
To:     Liming Sun <lsun@mellanox.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        David Woods <dwoods@mellanox.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 1, 2019 at 10:47 PM Liming Sun <lsun@mellanox.com> wrote:

Thanks for an update, my comments below.

(To Mellanox kernel developer team: guys, perhaps you need to
establish a few rounds of internal review before sending the stuff
outside)

First of all, I didn't find ABI documentation for interface this patch
introduces.
Must be added.

> +/* UUID used to probe ATF service. */
> +static const char * const mlxbf_bootctl_svc_uuid_str =
> +       "89c036b4-e7d7-11e6-8797-001aca00bfc4";

static const char *..._str = ...;

> +/* Syntactic sugar to avoid having to specify an unused argument. */
> +#define mlxbf_bootctl_smc_call0(smc_op) mlxbf_bootctl_smc_call1(smc_op, 0)

No.
Please, do it explicitly.

> +static const char *mlxbf_bootctl_reset_action_to_string(int action)
> +{
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(boot_names); i++)
> +               if (boot_names[i].value == action)
> +                       return boot_names[i].name;
> +

> +       return "";

Hmm...
Shouldn't be more descriptive?

> +}

> +static ssize_t post_reset_wdog_show(struct device_driver *drv, char *buf)
> +{
> +       return sprintf(buf, "%d\n",
> +               mlxbf_bootctl_smc_call0(MLXBF_BOOTCTL_GET_POST_RESET_WDOG));

What if call return negative error?

> +}

> +static ssize_t reset_action_show(struct device_driver *drv, char *buf)
> +{
> +       int action;
> +
> +       action = mlxbf_bootctl_smc_call0(MLXBF_BOOTCTL_GET_RESET_ACTION);

What if action goes negative?

> +       return sprintf(buf, "%s\n",
> +                      mlxbf_bootctl_reset_action_to_string(action));

Wouldn't be one line?

> +}

> +static ssize_t reset_action_store(struct device_driver *drv,
> +                                 const char *buf, size_t count)
> +{

> +       int ret, action = mlxbf_bootctl_reset_action_to_val(buf);

This should be like
int action;
int ret;

action = ...;
if (action ...)


> +       if (action == MLXBF_BOOTCTL_INVALID || action == MLXBF_BOOTCTL_NONE)
> +               return -EINVAL;

The mlxbf_bootctl_reset_action_to_val() has to return a proper Linux error code.
After this code should be modified to something like

if (action < 0)
 return action;

> +
> +       ret = (mlxbf_bootctl_smc_call1(MLXBF_BOOTCTL_SET_RESET_ACTION, action));

Redundant parens.

> +       if (ret < 0)
> +               return ret;
> +
> +       return count;
> +}
> +
> +static ssize_t second_reset_action_show(struct device_driver *drv, char *buf)
> +{
> +       int action;
> +       const char *name;
> +
> +       action = mlxbf_bootctl_smc_call0(MLXBF_BOOTCTL_GET_SECOND_RESET_ACTION);

What if action is negative?

> +       name = mlxbf_bootctl_reset_action_to_string(action);
> +
> +       return sprintf(buf, "%s\n", name);

return sprintf(... _to_string(...));
?

> +}
> +
> +static ssize_t second_reset_action_store(struct device_driver *drv,
> +                                        const char *buf, size_t count)
> +{

> +       int ret, action = mlxbf_bootctl_reset_action_to_val(buf);

int action;
int ret;

action = ...
if (action ...)

> +
> +       if (action < 0)
> +               return action;
> +
> +       ret = mlxbf_bootctl_smc_call1(MLXBF_BOOTCTL_SET_SECOND_RESET_ACTION,
> +                                     action);
> +       if (ret < 0)
> +               return ret;
> +
> +       return count;
> +}
> +
> +static ssize_t lifecycle_state_show(struct device_driver *drv, char *buf)
> +{
> +       int lc_state;
> +
> +       lc_state = mlxbf_bootctl_smc_call1(
> +                                          MLXBF_BOOTCTL_GET_TBB_FUSE_STATUS,
> +                                          MLXBF_BOOTCTL_FUSE_STATUS_LIFECYCLE);

> +

Redundant blank line.

> +       if (lc_state < 0)
> +               return lc_state;
> +
> +       lc_state &=
> +               (MLXBF_BOOTCTL_SB_TEST_MASK | MLXBF_BOOTCTL_SB_SECURE_MASK);

Actually parens are not needed. Sorry, I forgot to point to this earlier.

> +
> +       /*
> +        * If the test bits are set, we specify that the current state may be
> +        * due to using the test bits.
> +        */
> +       if (lc_state & MLXBF_BOOTCTL_SB_TEST_MASK) {
> +
> +               lc_state &= MLXBF_BOOTCTL_SB_SECURE_MASK;
> +
> +               return sprintf(buf, "%s(test)\n",
> +                              mlxbf_bootctl_lifecycle_states[lc_state]);
> +       }
> +
> +       return sprintf(buf, "%s\n", mlxbf_bootctl_lifecycle_states[lc_state]);
> +}
> +
> +static ssize_t secure_boot_fuse_state_show(struct device_driver *drv, char *buf)
> +{
> +       int sb_key_state = mlxbf_bootctl_smc_call1(
> +                               MLXBF_BOOTCTL_GET_TBB_FUSE_STATUS,
> +                               MLXBF_BOOTCTL_FUSE_STATUS_KEYS);

Split it to declaration and assignment.

> +       int upper_key_used = 0;
> +       int buf_len = 0;
> +       const char *status;
> +       int key;
> +
> +       if (sb_key_state < 0)
> +               return sb_key_state;
> +
> +       for (key = MLXBF_SB_KEY_NUM - 1; key >= 0; key--) {

> +               int burnt = sb_key_state & (1 << key);

BIT() ?

> +               int valid = sb_key_state &
> +                             (1 << (key + MLXBF_SB_KEY_NUM));

Ditto. And put to one line?

> +               buf_len += sprintf(buf + buf_len, "%d:", key);

Why this can't be part of the below sprintf() call?

> +               if (upper_key_used) {
> +                       if (burnt)
> +                               status = valid ? "Used" : "Wasted";
> +                       else
> +                               status = valid ? "Invalid" : "Skipped";
> +               } else {
> +                       if (burnt) {
> +                               status = valid ? "In use" : "Burn incomplete";

> +                               if (valid)
> +                                       upper_key_used = 1;

Move this out of this if-else-if block. The rationale is to split two
logical parts:
1) message choice
2) flag flip

> +                       } else
> +                               status = valid ? "Invalid" : "Free";
> +               }
> +               buf_len += sprintf(buf + buf_len, status);

> +               if (key != 0)
> +                       buf_len += sprintf(buf + buf_len, "; ");

Why do you need to check this?

> +       }
> +       buf_len += sprintf(buf + buf_len, "\n");
> +
> +       return buf_len;
> +}

> +static struct attribute_group mlxbf_bootctl_attr_group = {
> +       .attrs = mlxbf_bootctl_dev_attrs

+ comma.

> +};

> +static bool mlxbf_bootctl_guid_match(const guid_t *guid,
> +                                    const struct arm_smccc_res *res)
> +{

> +       guid_t id = GUID_INIT(res->a0, res->a1 & 0xFFFF,
> +                             (res->a1 >> 16) & 0xFFFF,
> +                             res->a2 & 0xff, (res->a2 >> 8) & 0xFF,
> +                             (res->a2 >> 16) & 0xFF, (res->a2 >> 24) & 0xFF,
> +                             res->a3 & 0xff, (res->a3 >> 8) & 0xFF,
> +                             (res->a3 >> 16) & 0xFF, (res->a3 >> 24) & 0xFF);

All & 0xFF* are done inside the macro, no need to duplicate.

> +
> +       return guid_equal(guid, &id);
> +}

> +static int mlxbf_bootctl_probe(struct platform_device *pdev)
> +{
> +       struct arm_smccc_res res;
> +       guid_t guid;
> +
> +       /* Ensure we have the UUID we expect for this service. */
> +       arm_smccc_smc(MLXBF_BOOTCTL_SIP_SVC_UID, 0, 0, 0, 0, 0, 0, 0, &res);
> +       guid_parse(mlxbf_bootctl_svc_uuid_str, &guid);
> +       if (!mlxbf_bootctl_guid_match(&guid, &res))
> +               return -ENODEV;
> +
> +       /*
> +        * When watchdog is used, it sets boot mode to MLXBF_BOOTCTL_SWAP_EMMC
> +        * in case of boot failures. However it doesn't clear the state if there
> +        * is no failure. Restore the default boot mode here to avoid any
> +        * unnecessary boot partition swapping.
> +        */

> +       if (mlxbf_bootctl_smc_call1(MLXBF_BOOTCTL_SET_RESET_ACTION,
> +                                   MLXBF_BOOTCTL_EMMC) < 0)

Use temporary variable here.

int ret;> +

...
ret = ..._call1(...);
if (ret < 0)

> +               dev_err(&pdev->dev, "Unable to reset the EMMC boot mode\n");

If it's error, why we return 0?
Otherwise, use warn level here.

> +
> +       return 0;
> +}
> +
> +static struct platform_driver mlxbf_bootctl_driver = {
> +       .probe = mlxbf_bootctl_probe,
> +       .driver = {
> +               .name = "mlxbf-bootctl",
> +               .groups = mlxbf_bootctl_attr_groups,

> +               .acpi_match_table = ACPI_PTR(mlxbf_bootctl_acpi_ids),

ACPI_PTR is redundant for the ACPI dependent driver.

> +       }
> +};

-- 
With Best Regards,
Andy Shevchenko
