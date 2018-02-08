Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751974AbeBHP0E (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 10:26:04 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:5188 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751310AbeBHP0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 10:26:03 -0500
Subject: Re: [PATCH 5/9] perf utils: add support for arch standard events
To: Jiri Olsa <jolsa@redhat.com>
References: <1517939104-230881-1-git-send-email-john.garry@huawei.com>
 <1517939104-230881-6-git-send-email-john.garry@huawei.com>
 <20180208135533.GI10234@krava>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <ak@linux.intel.com>, <wcohen@redhat.com>, <will.deacon@arm.com>,
        <ganapatrao.kulkarni@cavium.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <zhangshaokun@hisilicon.com>,
        <linux-arm-kernel@lists.infradead.org>
From: John Garry <john.garry@huawei.com>
Message-ID: <312796a3-9818-7793-9e28-7a686c990977@huawei.com>
Date: Thu, 8 Feb 2018 15:25:30 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20180208135533.GI10234@krava>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2018 13:55, Jiri Olsa wrote:
> On Wed, Feb 07, 2018 at 01:45:00AM +0800, John Garry wrote:
>
> SNIP
>
>>
>> +static int is_json_file(const char *name)
>> +{
>> +	const char *suffix;
>> +
>> +	if (strlen(name) < 5)
>> +		return 0;
>> +
>> +	suffix = name + strlen(name) - 5;
>> +
>> +	if (strncmp(suffix, ".json", 5) == 0)
>> +		return 1;
>> +	return 0;
>> +}
>> +
>> +static int preprocess_arch_std_files(const char *fpath, const struct stat *sb,
>> +				int typeflag, struct FTW *ftwbuf)
>> +{
>> +	int level = ftwbuf->level;
>> +	int is_file = typeflag == FTW_F;
>> +
>> +	if (level == 1 && is_file && is_json_file(fpath))
>> +		return json_events(fpath, save_arch_std_events, (void *)sb);
>
> so any .json file will pass..

Yes, so according to the scheme any architecture JSONs should be placed 
in the arch root folder.

just wondering you'd want to put
> some name restriction for recomended events file like this -recomended
> suffix you used later.. but that can be added later in case we'll
> need some other json files in here ;-)

Sorry, but I don't see what the naming restriction would mean in practice.

Thanks,
John

>
> jirka
>
> .
>
