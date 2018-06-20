Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25FDC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 971CC20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHtbpHr+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 971CC20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754822AbeFTRls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:41:48 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44547 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754288AbeFTRlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:41:45 -0400
Received: by mail-pf0-f193.google.com with SMTP id h12-v6so147795pfk.11;
        Wed, 20 Jun 2018 10:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0bCCK3WNKIJAPMIvQFBB0pCzxKxWbCPDOJqHk7+heY4=;
        b=cHtbpHr+wdA6YaYvfQTl3Mem5kwBuokQLbsyQPAyA3bj31SY9w1ih4Z64JARhclzjI
         U7rfpeBgXOsXnjlvkI4aa0jPujJzA5tnLCvhVVLu6/SD+VKBc7kjHlSR+2T3p7NC4Npt
         NUwvrfjupBnIYhPv61RyKFi4E7zCHUG9B2iiAmWh6dLgyr77EAK3oa3TnFmCcCll01dH
         OIkitlBtKHaucIlCrJTP25rNkckxL76os6rE5o+SfWlwd4Id0eLicQo9c8JNyZ2OvZ82
         P2pFFquS1iWjjEk0MsR4CbIZpnoNNrTeu0LXiHS08PoWyuqx/YLg2nDxV63mN8Jhf8p6
         EyNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0bCCK3WNKIJAPMIvQFBB0pCzxKxWbCPDOJqHk7+heY4=;
        b=aaKKEk8K4MC83cAUgVFWDd2o6aNPK9B+5JSyDDA3/FdIJPadLys2JNvP20MBVYAAGf
         uD8wk8T7kX5EoQLM+IOQF7aPZIDuuER7BxcPbCSYERuzh0z/7kJDqg2+U0Ik5Vcl0+f5
         ozdu3xu2XnBYt/Rla3Gd+odzI3wIodultt3hmMdTURoDWYjo5PUi5vUq3HTWsHo8QwbS
         a+WRldKRtg3kE+t+c9lvyChYD7OWN+QAOHinlTzsqK0kkjs4NSNsOz08KJef/qWHLdoR
         JrpuvKubCyUzaFA8R9zBScXJDb8Y0fYE+Z0dm7EivKNqndlFQMB7KsPOc+zCpGZkrA35
         +izQ==
X-Gm-Message-State: APt69E1kZcuGU+tig0cs4r8cCK4+jwEeHtGTUhWSXQjkNFegyjSvKVvS
        MdLMT9vADvLeS8lgwpgnKk4=
X-Google-Smtp-Source: ADUXVKIHlJFQXonidGI9NXFKZqiG3I3sY8akrJMayg+EfmNhGQTKw2LzhRHg9gD14scyLM3dpVuZ0Q==
X-Received: by 2002:a65:53cc:: with SMTP id z12-v6mr19706196pgr.350.1529516504736;
        Wed, 20 Jun 2018 10:41:44 -0700 (PDT)
Received: from gmail.com ([2620:15c:17:3:dc28:5c82:b905:e8a8])
        by smtp.gmail.com with ESMTPSA id t3-v6sm4832774pfk.161.2018.06.20.10.41.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 10:41:44 -0700 (PDT)
Date:   Wed, 20 Jun 2018 10:41:42 -0700
From:   Eric Biggers <ebiggers3@gmail.com>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        "Lee, Chun-Yi" <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Stephan Mueller <smueller@chronox.de>,
        Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/3][RFC] tools: create power/crypto utility
Message-ID: <20180620174142.GA76265@gmail.com>
References: <cover.1529486870.git.yu.c.chen@intel.com>
 <78af30838d0bac69bdd6e138b659bcbb8464fd13.1529486870.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78af30838d0bac69bdd6e138b659bcbb8464fd13.1529486870.git.yu.c.chen@intel.com>
User-Agent: Mutt/1.10+28 (db52f11e) (2018-06-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen,

On Wed, Jun 20, 2018 at 05:40:51PM +0800, Chen Yu wrote:
> crypto_hibernate is a user-space utility to generate
> 512bits AES key and pass it to the kernel via ioctl
> for hibernation encryption.(We can also add the key
> into kernel via keyctl if necessary, but currently
> using ioctl seems to be more straightforward as we
> need both the key and salt transit).
> 
> The key derivation is based on a simplified implementation
> of PBKDF2[1] in e2fsprogs - both the key length and the hash
> bytes are the same - 512bits. crypto_hibernate will firstly
> probe the user for passphrase and get salt from kernel, then
> uses them to generate a 512bits AES key based on PBKDF2.

What is a "512bits AES key"?  Do you mean AES-256-XTS (which takes a 512-bit
key, which the XTS mode internally splits into two keys)?  Do you allow for
other algorithms, or is it hardcoded to AES-256-XTS?  What if someone wants to
use a different algorithm?

BTW, it's difficult to review this with only patch 3/3 Cc'ed to me, as there is
no context about the problem you are trying to solve and what your actual
proposed kernel changes are.  I suggest Cc'ing linux-crypto on all 3 patches.

A few more comments below, from a very brief reading of the code:

[...]
> +
> +#define PBKDF2_ITERATIONS          0xFFFF
> +#define SHA512_BLOCKSIZE 128
> +#define SHA512_LENGTH 64
> +#define SALT_BYTES	16
> +#define SYM_KEY_BYTES SHA512_LENGTH
> +#define TOTAL_USER_INFO_LEN	(SALT_BYTES+SYM_KEY_BYTES)
> +#define MAX_PASSPHRASE_SIZE	1024
> +
> +struct hibernation_crypto_keys {
> +	char derived_key[SYM_KEY_BYTES];
> +	char salt[SALT_BYTES];
> +	bool valid;
> +};
> +
> +struct hibernation_crypto_keys hib_keys;
> +
> +static char *get_key_ptr(void)
> +{
> +	return hib_keys.derived_key;
> +}
> +
> +static char *get_salt_ptr(void)
> +{
> +	return hib_keys.salt;
> +}
[...]
> +
> +
> +#define HIBERNATE_SALT_READ      _IOW('C', 3, struct hibernation_crypto_keys)
> +#define HIBERNATE_KEY_WRITE     _IOW('C', 4, struct hibernation_crypto_keys)

Why are the ioctl numbers defined based on the size of 'struct
hibernation_crypto_keys'?  It's not a UAPI structure, right?

> +
> +static void get_passphrase(char *passphrase, int len)
> +{
> +	char *p;
> +	struct termios current_settings;
> +
> +	assert(len > 0);
> +	disable_echo(&current_settings);
> +	p = fgets(passphrase, len, stdin);
> +	tcsetattr(0, TCSANOW, &current_settings);
> +	printf("\n");
> +	if (!p) {
> +		printf("Aborting.\n");
> +		exit(1);
> +	}
> +	p = strrchr(passphrase, '\n');
> +	if (!p)
> +		p = passphrase + len - 1;
> +	*p = '\0';
> +}
> +
> +#define CRYPTO_FILE	"/dev/crypto_hibernate"
> +
> +static int write_keys(void)
> +{
> +	int fd;
> +
> +	fd = open(CRYPTO_FILE, O_RDWR);
> +	if (fd < 0) {
> +		printf("Cannot open device file...\n");
> +		return -EINVAL;
> +	}
> +	ioctl(fd, HIBERNATE_KEY_WRITE, get_key_ptr());
> +	return 0;

No error checking on the ioctl?

Also, how is the kernel supposed to know how long the key is, and which
algorithm it's supposed to be used for?  I assume it's hardcoded to AES-256-XTS?
What if someone wants to use a different algorithm?

> +}
> +
> +static int read_salt(void)
> +{
> +	int fd;
> +
> +	fd = open(CRYPTO_FILE, O_RDWR);
> +	if (fd < 0) {
> +		printf("Cannot open device file...\n");
> +		return -EINVAL;
> +	}
> +	ioctl(fd, HIBERNATE_SALT_READ, get_salt_ptr());
> +	return 0;
> +}

No error checking on the ioctl?

> +int main(int argc, char *argv[])
> +{
> +	int opt, option_index = 0;
> +	char in_passphrase[MAX_PASSPHRASE_SIZE];
> +
> +	while ((opt = getopt_long_only(argc, argv, "+p:s:h",
> +				NULL, &option_index)) != -1) {
> +		switch (opt) {
> +		case 'p':
> +			{
> +				char *p = optarg;
> +
> +				if (strlen(p) >= (MAX_PASSPHRASE_SIZE - 1)) {
> +					printf("Please provide passphrase less than %d bytes.\n",
> +						MAX_PASSPHRASE_SIZE);
> +					exit(1);
> +				}
> +				strcpy(in_passphrase, p);

I haven't read this super closely, but this really looks like an off-by-one
error.  It seems you intended MAX_PASSPHRASE_SIZE to include a null terminator,
so the correct check would be 'strlen(p) >= MAX_PASSPHRASE_SIZE'.

> +			}
> +			break;
> +		case 's':
> +			{
> +				char *p = optarg;
> +
> +				if (strlen(p) != (SALT_BYTES - 1)) {
> +					printf("Please provide salt with len less than %d bytes.\n",
> +						SALT_BYTES);
> +					exit(1);
> +				}
> +				strcpy(get_salt_ptr(), p);
> +			}
> +			break;

Salts don't need to be human-readable.  How about making the salt binary?  So, a
salt specified on the command-line would be hex.

Eric
