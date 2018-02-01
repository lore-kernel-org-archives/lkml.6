Date: Thu, 1 Feb 2018 18:00:28 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	jaegeuk@kernel.org, alex.lemberg@wdc.com
Subject: Re: [PATCH v4 02/10] ufs: sysfs: device descriptor
Message-ID: <20180201170028.GB12838@kroah.com>
References: <1517501746-19075-1-git-send-email-stanislav.nijnikov@wdc.com>
 <1517501746-19075-3-git-send-email-stanislav.nijnikov@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517501746-19075-3-git-send-email-stanislav.nijnikov@wdc.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 01, 2018 at 06:15:38PM +0200, Stanislav Nijnikov wrote:
> +#define UFS_DESC_PARAM(_name, _puname, _duname, _size)                        \
> +static ssize_t _name##_show(struct device *dev,                               \
> +	struct device_attribute *attr, char *buf)                             \
> +{                                                                             \
> +	struct ufs_hba *hba = dev_get_drvdata(dev);                           \
> +	return ufs_sysfs_read_desc_param(hba, QUERY_DESC_IDN_##_duname,       \
> +		0, _duname##_DESC_PARAM##_puname,                             \
> +		buf, UFS_PARAM_##_size##_SIZE);                               \
> +}                                                                             \
> +static DEVICE_ATTR_RO(_name)

Nit, use tabs in your lines here to line up the trailing \

Same for other places in this patch series.

thanks,

greg k-h
