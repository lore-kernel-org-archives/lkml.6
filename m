Date: Thu, 1 Feb 2018 18:03:12 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	jaegeuk@kernel.org, alex.lemberg@wdc.com
Subject: Re: [PATCH v4 10/10] ufs: sysfs: attributes
Message-ID: <20180201170312.GD12838@kroah.com>
References: <1517501746-19075-1-git-send-email-stanislav.nijnikov@wdc.com>
 <1517501746-19075-11-git-send-email-stanislav.nijnikov@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517501746-19075-11-git-send-email-stanislav.nijnikov@wdc.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 01, 2018 at 06:15:46PM +0200, Stanislav Nijnikov wrote:
> +#define UFS_LUN_ATTRIBUTE(_name, _uname)                                      \
> +static ssize_t _name##_attribute_show(struct device *dev,                     \
> +	struct device_attribute *attr, char *buf)                             \
> +{                                                                             \
> +	u32 value;                                                            \
> +	struct scsi_device *sdev = to_scsi_device(dev);                       \
> +	struct ufs_hba *hba = shost_priv(sdev->host);                         \
> +	u8 lun = ufshcd_scsi_to_upiu_lun(sdev->lun);                          \
> +	if (ufshcd_query_attr(hba, UPIU_QUERY_OPCODE_READ_ATTR,               \
> +		QUERY_ATTR_IDN##_uname, lun, 0, &value))                      \
> +		return -EINVAL;                                               \
> +	return sprintf(buf, "0x%08X\n", value);                               \
> +}                                                                             \
> +static DEVICE_ATTR_RO(_name##_attribute)
> +
> +UFS_LUN_ATTRIBUTE(dyn_cap_needed, _DYN_CAP_NEEDED);

Why create a macro when you only have one instance of its use?

thanks,

greg k-h
