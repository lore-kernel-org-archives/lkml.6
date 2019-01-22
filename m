Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E72DC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0517521019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548170938;
	bh=8RfXIU4vi7ACI7EYDywSZgq0cEyaQunjJlKoTrGL5Vw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZtSQAwJWBEBDiuyWs9Wh4SYPv/O/gqE59Ezo3Xd0HD0GH7i12/PXVKrAVNSLy/Fua
	 hlHi6i0KOGsUEvrsMkFgocqnb8R3wwidsTN6iVkmVOmncUF2dL5n4nVy0rgSeLjjE9
	 On5alFyJcumQ4Wid5DiZy0/9ac/M+j+PpZpO44oQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbfAVP24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:28:56 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:32955 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729224AbfAVP2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:28:55 -0500
Received: by mail-ot1-f66.google.com with SMTP id i20so24019224otl.0;
        Tue, 22 Jan 2019 07:28:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ESEcP8Z6+6bR1nt5KYN3bWWveT/pRbyebjkNfhIzUDI=;
        b=TwphlXLPiPRLqwfZEKaNzzHbnSAAOPpD8LKzkb7KHJjArpiKy2EcN9ZvXCBnAVqVNW
         3t7dhyVctSnDy/HsQDBhOKHwnXhdvtRDuJ7XDV79okguBDA6k9u6n5zOCuMyzSa7H6Bp
         LnC1cQClw09wJDsVW4euL9/+tEQhKJOk6opriA9a6l13bW6jOetwMx6tQurAj2Xg2nV0
         zcsLLzIY1XlhL9WHQ4/pUutcHb0xqL8b7MLKOyjEXq2vrwOrTjHXDyogDxzEoj2mtO2X
         AAMa9A2MmNux6uouUU77mG1tQGJ2y1iJG901jf5LlwUU94c38r8hhceoVlb6zAvuOd1k
         bqTg==
X-Gm-Message-State: AJcUukfDeY4kFgaCpEGaKdo8fAkgcGQWKMPj2CZAlNOEzfVhva+sBiw5
        5NVlovFPbJzCst+1l3q0RiYAK8MLmrcHUXny75Y=
X-Google-Smtp-Source: ALg8bN7rYAaCn/kgcW96pNSDaDMnkueZ6qHCEnHdfaep7kNhSVGp5MlBADI4BVao9029skZgH8C6Cy8bamQw4DVbIYc=
X-Received: by 2002:a9d:4c84:: with SMTP id m4mr20922266otf.124.1548170934634;
 Tue, 22 Jan 2019 07:28:54 -0800 (PST)
MIME-Version: 1.0
References: <20190122152151.16139-4-gregkh@linuxfoundation.org>
In-Reply-To: <20190122152151.16139-4-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Jan 2019 16:28:42 +0100
Message-ID: <CAJZ5v0jWvk+07vUx4=KOzw4mkz7yYjmoS+Uy8qixqmpW3o2mig@mail.gmail.com>
Subject: Re: [PATCH] acpi: no need to check return value of debugfs_create functions
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Yangtao Li <tiny.windzz@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 4:27 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Yangtao Li <tiny.windzz@gmail.com>
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Or do you want me to take this?

> ---
>  drivers/acpi/acpi_dbg.c      | 15 +------
>  drivers/acpi/apei/einj.c     | 86 +++++++++---------------------------
>  drivers/acpi/custom_method.c |  6 ---
>  drivers/acpi/ec_sys.c        | 36 ++++-----------
>  4 files changed, 32 insertions(+), 111 deletions(-)
>
> diff --git a/drivers/acpi/acpi_dbg.c b/drivers/acpi/acpi_dbg.c
> index a2dcd62ea32f..f3bca448b305 100644
> --- a/drivers/acpi/acpi_dbg.c
> +++ b/drivers/acpi/acpi_dbg.c
> @@ -752,11 +752,6 @@ int __init acpi_aml_init(void)
>  {
>         int ret = 0;
>
> -       if (!acpi_debugfs_dir) {
> -               ret = -ENOENT;
> -               goto err_exit;
> -       }
> -
>         /* Initialize AML IO interface */
>         mutex_init(&acpi_aml_io.lock);
>         init_waitqueue_head(&acpi_aml_io.wait);
> @@ -766,10 +761,6 @@ int __init acpi_aml_init(void)
>                                               S_IFREG | S_IRUGO | S_IWUSR,
>                                               acpi_debugfs_dir, NULL,
>                                               &acpi_aml_operations);
> -       if (acpi_aml_dentry == NULL) {
> -               ret = -ENODEV;
> -               goto err_exit;
> -       }
>         ret = acpi_register_debugger(THIS_MODULE, &acpi_aml_debugger);
>         if (ret)
>                 goto err_fs;
> @@ -788,10 +779,8 @@ void __exit acpi_aml_exit(void)
>  {
>         if (acpi_aml_initialized) {
>                 acpi_unregister_debugger(&acpi_aml_debugger);
> -               if (acpi_aml_dentry) {
> -                       debugfs_remove(acpi_aml_dentry);
> -                       acpi_aml_dentry = NULL;
> -               }
> +               debugfs_remove(acpi_aml_dentry);
> +               acpi_aml_dentry = NULL;
>                 acpi_aml_initialized = false;
>         }
>  }
> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> index fcccbfdbdd1a..c42299e048e4 100644
> --- a/drivers/acpi/apei/einj.c
> +++ b/drivers/acpi/apei/einj.c
> @@ -679,7 +679,6 @@ static int __init einj_init(void)
>  {
>         int rc;
>         acpi_status status;
> -       struct dentry *fentry;
>         struct apei_exec_context ctx;
>
>         if (acpi_disabled) {
> @@ -707,25 +706,13 @@ static int __init einj_init(void)
>
>         rc = -ENOMEM;
>         einj_debug_dir = debugfs_create_dir("einj", apei_get_debugfs_dir());
> -       if (!einj_debug_dir) {
> -               pr_err("Error creating debugfs node.\n");
> -               goto err_cleanup;
> -       }
>
> -       fentry = debugfs_create_file("available_error_type", S_IRUSR,
> -                                    einj_debug_dir, NULL,
> -                                    &available_error_type_fops);
> -       if (!fentry)
> -               goto err_cleanup;
> -
> -       fentry = debugfs_create_file("error_type", S_IRUSR | S_IWUSR,
> -                                    einj_debug_dir, NULL, &error_type_fops);
> -       if (!fentry)
> -               goto err_cleanup;
> -       fentry = debugfs_create_file("error_inject", S_IWUSR,
> -                                    einj_debug_dir, NULL, &error_inject_fops);
> -       if (!fentry)
> -               goto err_cleanup;
> +       debugfs_create_file("available_error_type", S_IRUSR, einj_debug_dir,
> +                           NULL, &available_error_type_fops);
> +       debugfs_create_file("error_type", S_IRUSR | S_IWUSR, einj_debug_dir,
> +                           NULL, &error_type_fops);
> +       debugfs_create_file("error_inject", S_IWUSR, einj_debug_dir,
> +                           NULL, &error_inject_fops);
>
>         apei_resources_init(&einj_resources);
>         einj_exec_ctx_init(&ctx);
> @@ -750,66 +737,37 @@ static int __init einj_init(void)
>         rc = -ENOMEM;
>         einj_param = einj_get_parameter_address();
>         if ((param_extension || acpi5) && einj_param) {
> -               fentry = debugfs_create_x32("flags", S_IRUSR | S_IWUSR,
> -                                           einj_debug_dir, &error_flags);
> -               if (!fentry)
> -                       goto err_unmap;
> -               fentry = debugfs_create_x64("param1", S_IRUSR | S_IWUSR,
> -                                           einj_debug_dir, &error_param1);
> -               if (!fentry)
> -                       goto err_unmap;
> -               fentry = debugfs_create_x64("param2", S_IRUSR | S_IWUSR,
> -                                           einj_debug_dir, &error_param2);
> -               if (!fentry)
> -                       goto err_unmap;
> -               fentry = debugfs_create_x64("param3", S_IRUSR | S_IWUSR,
> -                                           einj_debug_dir, &error_param3);
> -               if (!fentry)
> -                       goto err_unmap;
> -               fentry = debugfs_create_x64("param4", S_IRUSR | S_IWUSR,
> -                                           einj_debug_dir, &error_param4);
> -               if (!fentry)
> -                       goto err_unmap;
> -
> -               fentry = debugfs_create_x32("notrigger", S_IRUSR | S_IWUSR,
> -                                           einj_debug_dir, &notrigger);
> -               if (!fentry)
> -                       goto err_unmap;
> +               debugfs_create_x32("flags", S_IRUSR | S_IWUSR, einj_debug_dir,
> +                                  &error_flags);
> +               debugfs_create_x64("param1", S_IRUSR | S_IWUSR, einj_debug_dir,
> +                                  &error_param1);
> +               debugfs_create_x64("param2", S_IRUSR | S_IWUSR, einj_debug_dir,
> +                                  &error_param2);
> +               debugfs_create_x64("param3", S_IRUSR | S_IWUSR, einj_debug_dir,
> +                                  &error_param3);
> +               debugfs_create_x64("param4", S_IRUSR | S_IWUSR, einj_debug_dir,
> +                                  &error_param4);
> +               debugfs_create_x32("notrigger", S_IRUSR | S_IWUSR,
> +                                  einj_debug_dir, &notrigger);
>         }
>
>         if (vendor_dev[0]) {
>                 vendor_blob.data = vendor_dev;
>                 vendor_blob.size = strlen(vendor_dev);
> -               fentry = debugfs_create_blob("vendor", S_IRUSR,
> -                                            einj_debug_dir, &vendor_blob);
> -               if (!fentry)
> -                       goto err_unmap;
> -               fentry = debugfs_create_x32("vendor_flags", S_IRUSR | S_IWUSR,
> -                                           einj_debug_dir, &vendor_flags);
> -               if (!fentry)
> -                       goto err_unmap;
> +               debugfs_create_blob("vendor", S_IRUSR, einj_debug_dir,
> +                                   &vendor_blob);
> +               debugfs_create_x32("vendor_flags", S_IRUSR | S_IWUSR,
> +                                  einj_debug_dir, &vendor_flags);
>         }
>
>         pr_info("Error INJection is initialized.\n");
>
>         return 0;
>
> -err_unmap:
> -       if (einj_param) {
> -               acpi_size size = (acpi5) ?
> -                       sizeof(struct set_error_type_with_address) :
> -                       sizeof(struct einj_parameter);
> -
> -               acpi_os_unmap_iomem(einj_param, size);
> -               pr_err("Error creating param extension debugfs nodes.\n");
> -       }
> -       apei_exec_post_unmap_gars(&ctx);
>  err_release:
>         apei_resources_release(&einj_resources);
>  err_fini:
>         apei_resources_fini(&einj_resources);
> -err_cleanup:
> -       pr_err("Error creating primary debugfs nodes.\n");
>         debugfs_remove_recursive(einj_debug_dir);
>
>         return rc;
> diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
> index 4451877f83b6..aa972dc5cb7e 100644
> --- a/drivers/acpi/custom_method.c
> +++ b/drivers/acpi/custom_method.c
> @@ -79,14 +79,8 @@ static const struct file_operations cm_fops = {
>
>  static int __init acpi_custom_method_init(void)
>  {
> -       if (acpi_debugfs_dir == NULL)
> -               return -ENOENT;
> -
>         cm_dentry = debugfs_create_file("custom_method", S_IWUSR,
>                                         acpi_debugfs_dir, NULL, &cm_fops);
> -       if (cm_dentry == NULL)
> -               return -ENODEV;
> -
>         return 0;
>  }
>
> diff --git a/drivers/acpi/ec_sys.c b/drivers/acpi/ec_sys.c
> index dd70d6c2bca0..23faa66ea772 100644
> --- a/drivers/acpi/ec_sys.c
> +++ b/drivers/acpi/ec_sys.c
> @@ -108,52 +108,32 @@ static const struct file_operations acpi_ec_io_ops = {
>         .llseek = default_llseek,
>  };
>
> -static int acpi_ec_add_debugfs(struct acpi_ec *ec, unsigned int ec_device_count)
> +static void acpi_ec_add_debugfs(struct acpi_ec *ec, unsigned int ec_device_count)
>  {
>         struct dentry *dev_dir;
>         char name[64];
>         umode_t mode = 0400;
>
> -       if (ec_device_count == 0) {
> +       if (ec_device_count == 0)
>                 acpi_ec_debugfs_dir = debugfs_create_dir("ec", NULL);
> -               if (!acpi_ec_debugfs_dir)
> -                       return -ENOMEM;
> -       }
>
>         sprintf(name, "ec%u", ec_device_count);
>         dev_dir = debugfs_create_dir(name, acpi_ec_debugfs_dir);
> -       if (!dev_dir) {
> -               if (ec_device_count != 0)
> -                       goto error;
> -               return -ENOMEM;
> -       }
>
> -       if (!debugfs_create_x32("gpe", 0444, dev_dir, &first_ec->gpe))
> -               goto error;
> -       if (!debugfs_create_bool("use_global_lock", 0444, dev_dir,
> -                                &first_ec->global_lock))
> -               goto error;
> +       debugfs_create_x32("gpe", 0444, dev_dir, &first_ec->gpe);
> +       debugfs_create_bool("use_global_lock", 0444, dev_dir,
> +                           &first_ec->global_lock);
>
>         if (write_support)
>                 mode = 0600;
> -       if (!debugfs_create_file("io", mode, dev_dir, ec, &acpi_ec_io_ops))
> -               goto error;
> -
> -       return 0;
> -
> -error:
> -       debugfs_remove_recursive(acpi_ec_debugfs_dir);
> -       return -ENOMEM;
> +       debugfs_create_file("io", mode, dev_dir, ec, &acpi_ec_io_ops);
>  }
>
>  static int __init acpi_ec_sys_init(void)
>  {
> -       int err = 0;
>         if (first_ec)
> -               err = acpi_ec_add_debugfs(first_ec, 0);
> -       else
> -               err = -ENODEV;
> -       return err;
> +               acpi_ec_add_debugfs(first_ec, 0);
> +       return 0;
>  }
>
>  static void __exit acpi_ec_sys_exit(void)
> --
> 2.20.1
>
